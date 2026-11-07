import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  DatabaseService._();

  static final DatabaseService instance = DatabaseService._();
  Database? _database;

  static final List<Map<String, Object?>> _webGroups = [];
  static int _nextWebId = 1;
  static Map<String, Object?>? _webProfile;

  Future<Database> get database async {
    if (kIsWeb) {
      throw UnsupportedError('SQLite is not used in Chrome test mode.');
    }
    if (_database != null) return _database!;

    final folder = await getDatabasesPath();
    final path = join(folder, 'studypals.db');
    _database = await openDatabase(
      path,
      version: 3,
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
      },
    );
    return _database!;
  }

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
      return oldLength - _webGroups.length;
    }
    final db = await database;
    return db.delete('groups', where: 'id = ?', whereArgs: [id]);
  }

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
}
