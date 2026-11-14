import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  DatabaseService._();

  static final DatabaseService instance = DatabaseService._();
  Database? _database;

  // In-memory storage used when the app runs in Chrome (kIsWeb).
  static final List<Map<String, Object?>> _webGroups = [];
  static final List<Map<String, Object?>> _webBookings = [];
  static final List<Map<String, Object?>> _webMessages = [];
  static int _nextWebId = 1;
  static int _nextWebBookingId = 1;
  static int _nextWebMessageId = 1;
  static Map<String, Object?>? _webProfile;

  Future<void> _createModule3Tables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS bookings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tableId INTEGER NOT NULL,
        tableName TEXT NOT NULL,
        date TEXT NOT NULL,
        slotHour INTEGER NOT NULL,
        seats INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS messages (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        groupId INTEGER NOT NULL,
        sender TEXT NOT NULL,
        body TEXT NOT NULL,
        sentAt INTEGER NOT NULL
      )
    ''');
  }

  Future<Database> get database async {
    if (kIsWeb) {
      throw UnsupportedError('SQLite is not used in Chrome test mode.');
    }
    if (_database != null) return _database!;

    final folder = await getDatabasesPath();
    final path = join(folder, 'studypals.db');
    _database = await openDatabase(
      path,
      version: 4,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE groups (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            subject TEXT NOT NULL,
            description TEXT NOT NULL DEFAULT '',
            location TEXT NOT NULL,
            dateTime INTEGER NOT NULL,
            seats INTEGER NOT NULL,
            tags TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            university TEXT NOT NULL,
            department TEXT NOT NULL,
            semester TEXT NOT NULL
          )
        ''');
        await _createModule3Tables(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE users (
              id INTEGER PRIMARY KEY,
              name TEXT NOT NULL,
              university TEXT NOT NULL,
              department TEXT NOT NULL,
              semester TEXT NOT NULL
            )
          ''');
        }
        if (oldVersion < 3) {
          await db.execute(
            "ALTER TABLE groups ADD COLUMN description TEXT NOT NULL DEFAULT ''",
          );
        }
        if (oldVersion < 4) {
          await _createModule3Tables(db);
        }
      },
    );
    return _database!;
  }

  // ---------------------------------------------------------------------------
  // Study groups
  // ---------------------------------------------------------------------------

  Future<int> addGroup({
    required String name,
    required String subject,
    required String description,
    required String location,
    required DateTime dateTime,
    required int seats,
    required List<String> tags,
  }) async {
    if (kIsWeb) {
      final id = _nextWebId++;
      _webGroups.insert(0, {
        'id': id,
        'name': name,
        'subject': subject,
        'description': description,
        'location': location,
        'dateTime': dateTime,
        'seats': seats,
        'tags': List<String>.from(tags),
      });
      return id;
    }

    final db = await database;
    return db.insert('groups', {
      'name': name,
      'subject': subject,
      'description': description,
      'location': location,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'seats': seats,
      'tags': jsonEncode(tags),
    });
  }

  Future<List<Map<String, Object?>>> getGroups() async {
    if (kIsWeb) {
      return _webGroups.map((group) {
        return {...group, 'tags': List<String>.from(group['tags'] as List)};
      }).toList();
    }

    final db = await database;
    final rows = await db.query('groups', orderBy: 'id DESC');
    return rows.map((row) {
      return {
        ...row,
        'description': row['description'] ?? '',
        'dateTime': DateTime.fromMillisecondsSinceEpoch(row['dateTime'] as int),
        'tags': List<String>.from(jsonDecode(row['tags'] as String) as List),
      };
    }).toList();
  }

  Future<int> updateGroup({
    required int id,
    required String name,
    required String subject,
    required String description,
    required String location,
    required DateTime dateTime,
    required int seats,
    required List<String> tags,
  }) async {
    final values = <String, Object?>{
      'name': name,
      'subject': subject,
      'description': description,
      'location': location,
      'dateTime': dateTime,
      'seats': seats,
      'tags': List<String>.from(tags),
    };

    if (kIsWeb) {
      final index = _webGroups.indexWhere((group) => group['id'] == id);
      if (index < 0) return 0;
      _webGroups[index] = {'id': id, ...values};
      return 1;
    }

    final db = await database;
    return db.update(
      'groups',
      {
        ...values,
        'dateTime': dateTime.millisecondsSinceEpoch,
        'tags': jsonEncode(tags),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteGroup(int id) async {
    if (kIsWeb) {
      final oldLength = _webGroups.length;
      _webGroups.removeWhere((group) => group['id'] == id);
      _webMessages.removeWhere((message) => message['groupId'] == id);
      return oldLength - _webGroups.length;
    }
    final db = await database;
    // Also remove the chat messages that belonged to this group.
    await db.delete('messages', where: 'groupId = ?', whereArgs: [id]);
    return db.delete('groups', where: 'id = ?', whereArgs: [id]);
  }

  // ---------------------------------------------------------------------------
  // Profile
  // ---------------------------------------------------------------------------

  Future<Map<String, Object?>?> getProfile() async {
    if (kIsWeb) {
      return _webProfile == null
          ? null
          : Map<String, Object?>.from(_webProfile!);
    }
    final db = await database;
    final rows = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [1],
      limit: 1,
    );
    return rows.isEmpty ? null : rows.first;
  }

  Future<void> saveProfile({
    required String name,
    required String university,
    required String department,
    required String semester,
  }) async {
    final profile = {
      'id': 1,
      'name': name,
      'university': university,
      'department': department,
      'semester': semester,
    };

    if (kIsWeb) {
      _webProfile = profile;
      return;
    }
    final db = await database;
    await db.insert(
      'users',
      profile,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ---------------------------------------------------------------------------
  // Library bookings (Module 3)
  // ---------------------------------------------------------------------------

  /// [date] is stored as 'yyyy-MM-dd' and [slotHour] is the starting hour
  /// (24-hour clock), e.g. 14 means 2:00 PM - 3:00 PM.
  Future<int> addBooking({
    required int tableId,
    required String tableName,
    required String date,
    required int slotHour,
    required int seats,
  }) async {
    final values = <String, Object?>{
      'tableId': tableId,
      'tableName': tableName,
      'date': date,
      'slotHour': slotHour,
      'seats': seats,
    };

    if (kIsWeb) {
      final id = _nextWebBookingId++;
      _webBookings.add({'id': id, ...values});
      return id;
    }
    final db = await database;
    return db.insert('bookings', values);
  }

  Future<List<Map<String, Object?>>> getBookings() async {
    if (kIsWeb) {
      final rows = _webBookings
          .map((row) => Map<String, Object?>.from(row))
          .toList();
      rows.sort((a, b) {
        final byDate = (a['date'] as String).compareTo(b['date'] as String);
        if (byDate != 0) return byDate;
        return (a['slotHour'] as int).compareTo(b['slotHour'] as int);
      });
      return rows;
    }
    final db = await database;
    return db.query('bookings', orderBy: 'date ASC, slotHour ASC');
  }

  Future<int> deleteBooking(int id) async {
    if (kIsWeb) {
      final oldLength = _webBookings.length;
      _webBookings.removeWhere((row) => row['id'] == id);
      return oldLength - _webBookings.length;
    }
    final db = await database;
    return db.delete('bookings', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> getBookingCount() async {
    if (kIsWeb) return _webBookings.length;
    final db = await database;
    return Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM bookings'),
        ) ??
        0;
  }

  // ---------------------------------------------------------------------------
  // Group chat messages (Module 3)
  // ---------------------------------------------------------------------------

  Map<String, Object?> _messageFromRow(Map<String, Object?> row) {
    return {
      ...row,
      'sentAt': DateTime.fromMillisecondsSinceEpoch(row['sentAt'] as int),
    };
  }

  Future<int> addMessage({
    required int groupId,
    required String sender,
    required String body,
  }) async {
    if (kIsWeb) {
      final id = _nextWebMessageId++;
      _webMessages.add({
        'id': id,
        'groupId': groupId,
        'sender': sender,
        'body': body,
        'sentAt': DateTime.now(),
      });
      return id;
    }
    final db = await database;
    return db.insert('messages', {
      'groupId': groupId,
      'sender': sender,
      'body': body,
      'sentAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<List<Map<String, Object?>>> getMessages(int groupId) async {
    if (kIsWeb) {
      final rows = _webMessages
          .where((row) => row['groupId'] == groupId)
          .map((row) => Map<String, Object?>.from(row))
          .toList();
      rows.sort((a, b) => (a['id'] as int).compareTo(b['id'] as int));
      return rows;
    }
    final db = await database;
    final rows = await db.query(
      'messages',
      where: 'groupId = ?',
      whereArgs: [groupId],
      orderBy: 'id ASC',
    );
    return rows.map(_messageFromRow).toList();
  }

  /// Returns the most recent message of every group, keyed by group id.
  Future<Map<int, Map<String, Object?>>> getLastMessages() async {
    if (kIsWeb) {
      final result = <int, Map<String, Object?>>{};
      for (final row in _webMessages) {
        result[row['groupId'] as int] = Map<String, Object?>.from(row);
      }
      return result;
    }
    final db = await database;
    final rows = await db.rawQuery(
      'SELECT * FROM messages WHERE id IN '
      '(SELECT MAX(id) FROM messages GROUP BY groupId)',
    );
    return {
      for (final row in rows) row['groupId'] as int: _messageFromRow(row),
    };
  }

  Future<int> getMessageCount() async {
    if (kIsWeb) return _webMessages.length;
    final db = await database;
    return Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM messages'),
        ) ??
        0;
  }
}