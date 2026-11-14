import 'package:flutter/material.dart';

import 'database/database_service.dart';

const purple = Color(0xFF5637E8);
const deepPurple = Color(0xFF211653);
const lavender = Color(0xFFF6F4FF);
const lilac = Color(0xFFEAE6FF);
const green = Color(0xFF20B978);

void main() => runApp(const StudyPalsApp());

class StudyPalsApp extends StatelessWidget {
  const StudyPalsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudyPals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: lavender,
        colorScheme: ColorScheme.fromSeed(
          seedColor: purple,
          primary: purple,
          secondary: green,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: lavender,
          foregroundColor: deepPurple,
          elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFE5E1F2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFE5E1F2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: purple, width: 1.5),
          ),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}

class StudyGroup {
  const StudyGroup({
    this.id,
    required this.name,
    required this.subject,
    required this.description,
    required this.location,
    required this.dateTime,
    required this.seats,
    required this.tags,
  });

  final int? id;
  final String name;
  final String subject;
  final String description;
  final String location;
  final DateTime dateTime;
  final int seats;
  final List<String> tags;
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5D42EC), Color(0xFF9A82FF), Color(0xFFF7F5FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 0.48, 0.49],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.wifi, color: Colors.white70),
                ),
                const Spacer(),
                Container(
                  width: 170,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.82),
                    borderRadius: BorderRadius.circular(38),
                    boxShadow: [
                      BoxShadow(
                        color: deepPurple.withValues(alpha: 0.12),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(Icons.menu_book_rounded, size: 88, color: purple),
                      Positioned(
                        top: 17,
                        child: Icon(
                          Icons.school_rounded,
                          size: 52,
                          color: deepPurple,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 26),
                const Text(
                  'StudyPals',
                  style: TextStyle(
                    color: purple,
                    fontSize: 38,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.4,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Find study groups,\nbook library slots,\nachieve together!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: deepPurple,
                    height: 1.5,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: purple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const StudyPalsHome()),
                    ),
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool hidePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _continueToApp() {
    if (!formKey.currentState!.validate()) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const StudyPalsHome()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 6, 24, 30),
            children: [
              const SizedBox(height: 12),
              const Center(
                child: Icon(Icons.school_rounded, size: 58, color: purple),
              ),
              const SizedBox(height: 6),
              const Center(
                child: Text(
                  'StudyPals',
                  style: TextStyle(
                    color: deepPurple,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Welcome Back!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: deepPurple,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Login to continue',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 28),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.person_outline, color: purple),
                ),
                validator: (value) {
                  final email = value?.trim() ?? '';
                  if (!email.contains('@') || !email.contains('.')) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: passwordController,
                obscureText: hidePassword,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _continueToApp(),
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline, color: purple),
                  suffixIcon: IconButton(
                    onPressed: () =>
                        setState(() => hidePassword = !hidePassword),
                    icon: Icon(
                      hidePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.black54,
                    ),
                  ),
                ),
                validator: (value) => value == null || value.length < 6
                    ? 'Use at least 6 characters'
                    : null,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Password recovery is not connected in this project yet.',
                      ),
                    ),
                  ),
                  child: const Text('Forgot Password?'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 54,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: purple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: _continueToApp,
                  child: const Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('or'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 14),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  foregroundColor: deepPurple,
                  side: const BorderSide(color: Color(0xFFE2DDF3)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: _continueToApp,
                icon: const Icon(Icons.person, color: purple),
                label: const Text('Continue to StudyPals'),
              ),
              const SizedBox(height: 18),
              const Text(
                'Demo screen: account authentication is not connected. Any valid email and a 6-character password will continue.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don’t have an account?'),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignUpScreen()),
                    ),
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final universityController = TextEditingController();
  final departmentController = TextEditingController();
  final semesterController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool hidePassword = true;
  bool saving = false;

  @override
  void dispose() {
    nameController.dispose();
    universityController.dispose();
    departmentController.dispose();
    semesterController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _createDemoProfile() async {
    if (!formKey.currentState!.validate()) return;
    setState(() => saving = true);
    try {
      await DatabaseService.instance.saveProfile(
        name: nameController.text.trim(),
        university: universityController.text.trim(),
        department: departmentController.text.trim(),
        semester: semesterController.text.trim(),
      );
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const StudyPalsHome()),
        (_) => false,
      );
    } catch (error) {
      if (!mounted) return;
      setState(() => saving = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not save profile: $error')));
    }
  }

  Widget _signUpField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    bool password = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: password && hidePassword,
        textCapitalization: password
            ? TextCapitalization.none
            : TextCapitalization.words,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: purple),
          suffixIcon: password
              ? IconButton(
                  onPressed: () => setState(() => hidePassword = !hidePassword),
                  icon: Icon(
                    hidePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                )
              : null,
        ),
        validator: (value) {
          final text = value?.trim() ?? '';
          if (text.isEmpty) return 'Enter $label';
          if (password && text.length < 6) return 'Use at least 6 characters';
          if (keyboardType == TextInputType.emailAddress &&
              (!text.contains('@') || !text.contains('.'))) {
            return 'Enter a valid email address';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create your profile')),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          children: [
            const Text(
              'Join StudyPals',
              style: TextStyle(
                color: deepPurple,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Add your student details to get started.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 22),
            _signUpField(
              controller: nameController,
              label: 'Student name',
              icon: Icons.person_outline,
            ),
            _signUpField(
              controller: universityController,
              label: 'University',
              icon: Icons.account_balance_outlined,
            ),
            _signUpField(
              controller: departmentController,
              label: 'Department or degree',
              icon: Icons.school_outlined,
            ),
            _signUpField(
              controller: semesterController,
              label: 'Semester',
              icon: Icons.calendar_month_outlined,
            ),
            _signUpField(
              controller: emailController,
              label: 'Email address',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            _signUpField(
              controller: passwordController,
              label: 'Password',
              icon: Icons.lock_outline,
              password: true,
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 54,
              child: FilledButton(
                onPressed: saving ? null : _createDemoProfile,
                child: saving
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Create Account'),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Demo sign-up saves your profile on this device. It does not create an online account or store your password.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudyPalsHome extends StatefulWidget {
  const StudyPalsHome({super.key});

  @override
  State<StudyPalsHome> createState() => _StudyPalsHomeState();
}

class _StudyPalsHomeState extends State<StudyPalsHome> {
  int selectedTab = 0; // 0 Home, 1 Groups, 2 Library, 3 Profile, 4 Chats
  bool loading = true;
  final groups = <StudyGroup>[];
  final searchController = TextEditingController();
  Map<String, Object?>? profile;
  String selectedSubject = 'All';
  TimeFilter timeFilter = TimeFilter.any;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _message(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _loadData() async {
    try {
      final rows = await DatabaseService.instance.getGroups();
      final savedProfile = await DatabaseService.instance.getProfile();
      final loadedGroups = rows.map((row) {
        return StudyGroup(
          id: row['id'] as int,
          name: row['name'] as String,
          subject: row['subject'] as String,
          description: row['description'] as String? ?? '',
          location: row['location'] as String,
          dateTime: row['dateTime'] as DateTime,
          seats: row['seats'] as int,
          tags: List<String>.from(row['tags'] as List),
        );
      }).toList();

      if (!mounted) return;
      setState(() {
        groups
          ..clear()
          ..addAll(loadedGroups);
        profile = savedProfile;
        loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => loading = false);
      _message('Could not load saved information: $error');
    }
  }

  String _dateTimeLabel(DateTime value) {
    final date = '${value.day}/${value.month}/${value.year}';
    final hour = value.hour % 12 == 0 ? 12 : value.hour % 12;
    final minute = value.minute.toString().padLeft(2, '0');
    return '$date • $hour:$minute ${value.hour >= 12 ? 'PM' : 'AM'}';
  }

  // The form screen saves to the database itself (with a loading spinner),
  // so here we only update the list on screen.
  Future<void> _openGroupForm({StudyGroup? group}) async {
    final result = await Navigator.push<StudyGroup>(
      context,
      MaterialPageRoute(builder: (_) => GroupFormScreen(group: group)),
    );
    if (!mounted || result == null) return;

    setState(() {
      final index = groups.indexWhere((item) => item.id == result.id);
      if (index >= 0) {
        groups[index] = result;
      } else {
        groups.insert(0, result);
      }
    });
    _message(
      group == null
          ? 'Study group created successfully!'
          : 'Group changes saved!',
    );
  }

  Future<void> _deleteGroup(StudyGroup group) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete this group?'),
        content: Text('Remove “${group.name}” from StudyPals?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true || group.id == null) return;
    try {
      await DatabaseService.instance.deleteGroup(group.id!);
      if (!mounted) return;
      setState(() => groups.removeWhere((item) => item.id == group.id));
      _message('Study group deleted.');
    } catch (error) {
      _message('Could not delete group: $error');
    }
  }

  void _showGroupDetails(StudyGroup group) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 8, 22, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                group.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                group.subject,
                style: const TextStyle(
                  color: purple,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 18),
              _detail(
                Icons.event_seat_outlined,
                '${group.seats} seats available',
              ),
              _detail(
                Icons.calendar_month_outlined,
                _dateTimeLabel(group.dateTime),
              ),
              _detail(Icons.location_on_outlined, group.location),
              if (group.description.isNotEmpty) ...[
                const SizedBox(height: 14),
                const Text(
                  'About this group',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: deepPurple,
                  ),
                ),
                const SizedBox(height: 5),
                Text(group.description),
              ],
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: group.tags
                    .map(
                      (tag) => Chip(label: Text(tag), backgroundColor: lilac),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detail(IconData icon, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 9),
    child: Row(
      children: [
        Icon(icon, size: 19, color: purple),
        const SizedBox(width: 10),
        Expanded(child: Text(text)),
      ],
    ),
  );

  List<String> get _subjects =>
      groups
          .map((g) => g.subject)
          .where((s) => s.trim().isNotEmpty)
          .toSet()
          .toList()
        ..sort();

  bool get _filtersActive =>
      selectedSubject != 'All' || timeFilter != TimeFilter.any;

  Future<void> _openFilters() async {
    final result = await showGroupFilterSheet(
      context,
      subjects: _subjects,
      subject: selectedSubject,
      time: timeFilter,
    );
    if (result == null) return;
    setState(() {
      selectedSubject = result.subject;
      timeFilter = result.time;
    });
  }

  List<StudyGroup> get _visibleGroups {
    final query = searchController.text.trim().toLowerCase();
    return groups.where((group) {
      final matchesSubject =
          selectedSubject == 'All' || group.subject == selectedSubject;
      final matchesQuery =
          query.isEmpty ||
          group.name.toLowerCase().contains(query) ||
          group.subject.toLowerCase().contains(query) ||
          group.tags.any((tag) => tag.toLowerCase().contains(query));
      return matchesSubject &&
          matchesQuery &&
          matchesTimeFilter(group.dateTime, timeFilter);
    }).toList();
  }

  Widget _searchBox({String hint = 'Search study groups...'}) => TextField(
    controller: searchController,
    onChanged: (_) => setState(() {}),
    decoration: InputDecoration(
      hintText: hint,
      prefixIcon: const Icon(Icons.search, color: purple),
      suffixIcon: searchController.text.isEmpty
          ? null
          : IconButton(
              onPressed: () {
                searchController.clear();
                setState(() {});
              },
              icon: const Icon(Icons.close),
            ),
    ),
  );

  Widget _subjectChips({bool showAll = true}) {
    final options = <String>[if (showAll) 'All', ..._subjects];
    if (options.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final subject = options[index];
          final selected = selectedSubject == subject;
          return ChoiceChip(
            label: Text(subject),
            selected: selected,
            onSelected: (_) => setState(() => selectedSubject = subject),
            selectedColor: purple,
            backgroundColor: Colors.white,
            labelStyle: TextStyle(
              color: selected ? Colors.white : deepPurple,
              fontWeight: FontWeight.w600,
            ),
            side: BorderSide.none,
          );
        },
      ),
    );
  }

  Widget _groupCard(StudyGroup group, {bool compact = false}) {
    return Card(
      color: Colors.white,
      elevation: 1,
      shadowColor: deepPurple.withValues(alpha: 0.08),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: lilac,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.menu_book_rounded,
                color: purple,
                size: 29,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    group.subject,
                    style: const TextStyle(
                      color: purple,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${group.seats} seats available',
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  if (!compact) ...[
                    const SizedBox(height: 3),
                    Text(
                      _dateTimeLabel(group.dateTime),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 11,
                      ),
                    ),
                  ],
                  if (group.tags.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 5,
                      runSpacing: 3,
                      children: group.tags
                          .take(2)
                          .map((tag) => _tagPill(tag))
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
            if (!compact)
              PopupMenuButton<String>(
                onSelected: (action) {
                  if (action == 'edit') _openGroupForm(group: group);
                  if (action == 'delete') _deleteGroup(group);
                  if (action == 'details') _showGroupDetails(group);
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'details', child: Text('View details')),
                  PopupMenuItem(value: 'edit', child: Text('Edit group')),
                  PopupMenuItem(value: 'delete', child: Text('Delete group')),
                ],
              )
            else
              TextButton(
                onPressed: () => _showGroupDetails(group),
                child: const Text('View'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _tagPill(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
    decoration: BoxDecoration(
      color: lilac,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: purple,
        fontSize: 10,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  Widget _quickTile({
    required IconData icon,
    required String title,
    required List<Color> colors,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          height: 126,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: colors.first.withValues(alpha: 0.2),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 34),
              const SizedBox(height: 9),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _homePage() {
    final name = profile?['name'] as String? ?? 'Student';
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'StudyPals',
          style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -0.3),
        ),
        actions: [
          IconButton(
            onPressed: () => _message('No new notifications.'),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator(color: purple))
          : ListView(
              padding: const EdgeInsets.fromLTRB(18, 5, 18, 100),
              children: [
                Text(
                  'Hello, $name! 👋',
                  style: const TextStyle(
                    color: deepPurple,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Let's study smart together",
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 18),
                _searchBox(),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _quickTile(
                      icon: Icons.groups_rounded,
                      title: 'Find Study Groups',
                      colors: const [purple, Color(0xFF886AFF)],
                      onTap: () => setState(() => selectedTab = 1),
                    ),
                    const SizedBox(width: 12),
                    _quickTile(
                      icon: Icons.menu_book_rounded,
                      title: 'Check Library Slots',
                      colors: const [Color(0xFF19B875), Color(0xFF52D49A)],
                      onTap: () => setState(() => selectedTab = 2),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _sectionTitle(
                  'Popular Subjects',
                  action: 'See all',
                  onAction: () => setState(() => selectedTab = 1),
                ),
                const SizedBox(height: 10),
                if (_subjects.isEmpty)
                  const Text(
                    'Create a group to see subjects here.',
                    style: TextStyle(color: Colors.black54),
                  )
                else
                  SizedBox(
                    height: 42,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _subjects.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (_, index) => ActionChip(
                        label: Text(_subjects[index]),
                        backgroundColor: index == 0 ? purple : Colors.white,
                        labelStyle: TextStyle(
                          color: index == 0 ? Colors.white : deepPurple,
                          fontWeight: FontWeight.w600,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedSubject = _subjects[index];
                            selectedTab = 1;
                          });
                        },
                      ),
                    ),
                  ),
                const SizedBox(height: 22),
                _sectionTitle(
                  'Active Groups',
                  action: 'See all',
                  onAction: () => setState(() => selectedTab = 1),
                ),
                const SizedBox(height: 10),
                if (groups.isEmpty)
                  _emptyGroups(onCreate: () => _openGroupForm())
                else
                  ...groups
                      .take(3)
                      .map((group) => _groupCard(group, compact: true)),
              ],
            ),
    );
  }

  Widget _sectionTitle(
    String title, {
    String? action,
    VoidCallback? onAction,
  }) => Row(
    children: [
      Expanded(
        child: Text(
          title,
          style: const TextStyle(
            color: deepPurple,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      if (action != null) TextButton(onPressed: onAction, child: Text(action)),
    ],
  );

  Widget _emptyGroups({required VoidCallback onCreate}) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      children: [
        const Icon(Icons.groups_outlined, color: purple, size: 38),
        const SizedBox(height: 8),
        const Text(
          'No study groups yet',
          style: TextStyle(color: deepPurple, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        const Text(
          'Create one and invite classmates.',
          style: TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 10),
        FilledButton(onPressed: onCreate, child: const Text('Create a group')),
      ],
    ),
  );

  Widget _groupsPage() {
    final visible = _visibleGroups;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Study Groups',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => setState(() => selectedTab = 0),
        ),
        actions: [
          IconButton(
            onPressed: _openFilters,
            icon: Badge(
              isLabelVisible: _filtersActive,
              smallSize: 9,
              child: const Icon(Icons.tune_rounded),
            ),
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator(color: purple))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
                  child: _searchBox(hint: 'Search groups...'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: _subjectChips(),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: visible.isEmpty
                      ? Center(
                          child: Text(
                            groups.isEmpty
                                ? 'No groups yet. Tap + to create one.'
                                : 'No groups match your search or filters.',
                            style: const TextStyle(color: Colors.black54),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(14, 2, 14, 90),
                          itemCount: visible.length,
                          itemBuilder: (_, index) => _groupCard(visible[index]),
                        ),
                ),
              ],
            ),
    );
  }

  Future<void> _editProfile() async {
    final values = await showDialog<Map<String, String>>(
      context: context,
      builder: (_) => ProfileEditDialog(profile: profile),
    );
    if (values == null) return;
    try {
      await DatabaseService.instance.saveProfile(
        name: values['name']!,
        university: values['university']!,
        department: values['department']!,
        semester: values['semester']!,
      );
      final saved = await DatabaseService.instance.getProfile();
      if (!mounted) return;
      setState(() => profile = saved);
      _message('Profile saved!');
    } catch (error) {
      _message('Could not save profile: $error');
    }
  }

  Widget _profilePage() {
    final name = profile?['name'] as String? ?? '';
    final firstLetter = name.trim().isEmpty
        ? '?'
        : name.trim()[0].toUpperCase();
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: loading
          ? const Center(child: CircularProgressIndicator(color: purple))
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 28, 20, 22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [purple, Color(0xFF8873F7)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 42,
                        backgroundColor: Colors.white,
                        child: Text(
                          firstLetter,
                          style: const TextStyle(
                            color: purple,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        name.isEmpty ? 'Your name' : name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        profile?['university'] as String? ??
                            'Add your university',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _profileStat('${groups.length}', 'Groups'),
                          Container(
                            height: 34,
                            width: 1,
                            color: Colors.white30,
                            margin: const EdgeInsets.symmetric(horizontal: 22),
                          ),
                          _profileStat(
                            profile == null ? 'New' : 'Active',
                            'Student',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    children: [
                      _profileDetail(
                        Icons.school_outlined,
                        'Department or degree',
                        profile?['department'] as String?,
                      ),
                      const Divider(height: 1, indent: 16, endIndent: 16),
                      _profileDetail(
                        Icons.calendar_month_outlined,
                        'Semester',
                        profile?['semester'] as String?,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 52,
                  child: FilledButton.icon(
                    onPressed: _editProfile,
                    icon: const Icon(Icons.edit_outlined),
                    label: Text(
                      profile == null ? 'Add profile details' : 'Edit profile',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ProfileBadges(
                  groupCount: groups.length,
                  refreshToken: selectedTab * 1000 + groups.length,
                ),
              ],
            ),
    );
  }

  Widget _profileStat(String value, String label) => Column(
    children: [
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 2),
      Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
    ],
  );

  Widget _profileDetail(IconData icon, String label, String? value) => ListTile(
    leading: Icon(icon, color: purple),
    title: Text(
      label,
      style: const TextStyle(color: Colors.black54, fontSize: 13),
    ),
    subtitle: Text(
      value == null || value.isEmpty ? 'Not added yet' : value,
      style: const TextStyle(color: deepPurple, fontWeight: FontWeight.w600),
    ),
  );

  Widget _navItem(int index, IconData icon, String label) {
    final active = selectedTab == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => selectedTab = index),
        child: SizedBox(
          height: 62,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: active ? purple : const Color(0xFF858198),
                size: 22,
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: TextStyle(
                  color: active ? purple : const Color(0xFF858198),
                  fontSize: 10,
                  fontWeight: active ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Page order matches the tab numbers: 0 Home, 1 Groups, 2 Library,
    // 3 Profile, 4 Chats.
    final pages = [
      _homePage(),
      _groupsPage(),
      const LibraryScreen(),
      _profilePage(),
      ChatListScreen(refreshToken: selectedTab * 1000 + groups.length),
    ];
    return Scaffold(
      body: IndexedStack(index: selectedTab, children: pages),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openGroupForm(),
        backgroundColor: purple,
        foregroundColor: Colors.white,
        elevation: 5,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 12,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 62,
          child: Row(
            children: [
              _navItem(0, Icons.home_outlined, 'Home'),
              _navItem(1, Icons.groups_outlined, 'Groups'),
              const SizedBox(width: 56),
              _navItem(2, Icons.menu_book_outlined, 'Library'),
              _navItem(4, Icons.chat_bubble_outline, 'Chats'),
              _navItem(3, Icons.person_outline, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}

class GroupFormScreen extends StatefulWidget {
  const GroupFormScreen({super.key, this.group});
  final StudyGroup? group;

  @override
  State<GroupFormScreen> createState() => _GroupFormScreenState();
}

class _GroupFormScreenState extends State<GroupFormScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final tagController = TextEditingController();
  final Set<String> tags = {};
  DateTime? date;
  TimeOfDay? time;
  int seats = 5;
  bool saving = false;

  bool get editing => widget.group != null;

  @override
  void initState() {
    super.initState();
    final group = widget.group;
    if (group != null) {
      nameController.text = group.name;
      subjectController.text = group.subject;
      descriptionController.text = group.description;
      locationController.text = group.location;
      date = group.dateTime;
      time = TimeOfDay.fromDateTime(group.dateTime);
      seats = group.seats;
      tags.addAll(group.tags);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    subjectController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    tagController.dispose();
    super.dispose();
  }

  void _addTag() {
    final value = tagController.text.trim();
    if (value.isEmpty) return;
    if (tags.any((tag) => tag.toLowerCase() == value.toLowerCase())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This tag is already added.')),
      );
      return;
    }
    setState(() {
      tags.add(value);
      tagController.clear();
    });
  }

  Future<void> _pickDate() async {
    final today = DateTime.now();
    final start = date != null && date!.isBefore(today) ? date! : today;
    final result = await showDatePicker(
      context: context,
      initialDate: date ?? today,
      firstDate: start,
      lastDate: DateTime(today.year + 2),
    );
    if (result != null) setState(() => date = result);
  }

  Future<void> _pickTime() async {
    final result = await showTimePicker(
      context: context,
      initialTime: time ?? TimeOfDay.now(),
    );
    if (result != null) setState(() => time = result);
  }

  Future<void> _save() async {
    if (saving) return;
    if (!formKey.currentState!.validate()) return;
    if (date == null || time == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Choose a date and time slot.')),
      );
      return;
    }
    final dateTime = DateTime(
      date!.year,
      date!.month,
      date!.day,
      time!.hour,
      time!.minute,
    );
    final timeChanged = !editing || dateTime != widget.group!.dateTime;
    if (timeChanged && !dateTime.isAfter(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pick a date and time in the future.')),
      );
      return;
    }
    if (tags.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add at least one subject tag.')),
      );
      return;
    }

    setState(() => saving = true);
    final name = nameController.text.trim();
    final subject = subjectController.text.trim();
    final description = descriptionController.text.trim();
    final location = locationController.text.trim();
    final tagList = tags.toList();
    try {
      int id;
      if (editing && widget.group!.id != null) {
        id = widget.group!.id!;
        await DatabaseService.instance.updateGroup(
          id: id,
          name: name,
          subject: subject,
          description: description,
          location: location,
          dateTime: dateTime,
          seats: seats,
          tags: tagList,
        );
      } else {
        id = await DatabaseService.instance.addGroup(
          name: name,
          subject: subject,
          description: description,
          location: location,
          dateTime: dateTime,
          seats: seats,
          tags: tagList,
        );
      }
      if (!mounted) return;
      Navigator.pop(
        context,
        StudyGroup(
          id: id,
          name: name,
          subject: subject,
          description: description,
          location: location,
          dateTime: dateTime,
          seats: seats,
          tags: tagList,
        ),
      );
    } catch (error) {
      if (!mounted) return;
      setState(() => saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not save group: $error')),
      );
    }
  }

  Widget _field({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    String? hint,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 13),
    child: TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: purple),
      ),
      validator: (value) {
        final text = value?.trim() ?? '';
        if (text.isEmpty) return 'Please enter $label';
        if (label == 'Group name' && text.length < 3) {
          return 'Name must be at least 3 characters';
        }
        final limit = maxLines > 1 ? 300 : 80;
        if (text.length > limit) {
          return 'Keep $label under $limit characters';
        }
        return null;
      },
    ),
  );

  Widget _formCard(
    String title,
    String subtitle,
    IconData icon,
    Widget child,
  ) => Card(
    color: Colors.white,
    elevation: 0,
    margin: const EdgeInsets.only(bottom: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: const BorderSide(color: Color(0xFFE9E5F5)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: purple),
              const SizedBox(width: 9),
              Text(
                title,
                style: const TextStyle(
                  color: deepPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
          const SizedBox(height: 15),
          child,
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editing ? 'Edit Study Group' : 'Create Study Group'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [purple, Color(0xFF8B78FF)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                editing
                    ? 'Update the details for your study group.'
                    : 'Bring classmates together to learn.',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            _formCard(
              'Group details',
              'Tell students what and where you will study.',
              Icons.groups_rounded,
              Column(
                children: [
                  _field(
                    label: 'Group name',
                    controller: nameController,
                    icon: Icons.edit_outlined,
                    hint: 'e.g. CS Study Group',
                  ),
                  _field(
                    label: 'Main subject',
                    controller: subjectController,
                    icon: Icons.menu_book_outlined,
                    hint: 'Type any subject',
                  ),
                  _field(
                    label: 'Description',
                    controller: descriptionController,
                    icon: Icons.notes_outlined,
                    hint: 'Tell students about your group...',
                    maxLines: 3,
                  ),
                  _field(
                    label: 'Meeting location',
                    controller: locationController,
                    icon: Icons.location_on_outlined,
                    hint: 'e.g. Central Library',
                  ),
                ],
              ),
            ),
            _formCard(
              'Subject tags',
              'Type a subject or topic, then tap + to add it.',
              Icons.local_offer_outlined,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: tagController,
                    textCapitalization: TextCapitalization.words,
                    onSubmitted: (_) => _addTag(),
                    decoration: InputDecoration(
                      hintText: 'e.g. Computer Science',
                      suffixIcon: IconButton(
                        onPressed: _addTag,
                        icon: const Icon(Icons.add_circle, color: purple),
                      ),
                    ),
                  ),
                  if (tags.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 7,
                      runSpacing: 4,
                      children: tags
                          .map(
                            (tag) => InputChip(
                              label: Text(tag),
                              backgroundColor: lilac,
                              onDeleted: () => setState(() => tags.remove(tag)),
                            ),
                          )
                          .toList(),
                    ),
                  ] else ...[
                    const SizedBox(height: 9),
                    const Text(
                      'No tags added yet.',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ],
              ),
            ),
            _formCard(
              'Time slot',
              'Choose the day and time for your meeting.',
              Icons.calendar_month_outlined,
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_today_outlined),
                      label: Text(
                        date == null
                            ? 'Select date'
                            : '${date!.day}/${date!.month}/${date!.year}',
                      ),
                    ),
                  ),
                  const SizedBox(height: 9),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: _pickTime,
                      icon: const Icon(Icons.access_time),
                      label: Text(time?.format(context) ?? 'Select time'),
                    ),
                  ),
                ],
              ),
            ),
            _formCard(
              'Available seats',
              'How many students can join this group?',
              Icons.event_seat_outlined,
              Row(
                children: [
                  IconButton.filledTonal(
                    onPressed: seats > 1 ? () => setState(() => seats--) : null,
                    icon: const Icon(Icons.remove),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '$seats',
                          style: const TextStyle(
                            color: deepPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 27,
                          ),
                        ),
                        const Text('seats available'),
                      ],
                    ),
                  ),
                  IconButton.filledTonal(
                    onPressed: seats < 50
                        ? () => setState(() => seats++)
                        : null,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 54,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: purple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: saving ? null : _save,
                icon: saving
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Icon(editing ? Icons.save_outlined : Icons.add),
                label: Text(
                  editing ? 'Save changes' : 'Create Group',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileEditDialog extends StatefulWidget {
  const ProfileEditDialog({super.key, required this.profile});
  final Map<String, Object?>? profile;

  @override
  State<ProfileEditDialog> createState() => _ProfileEditDialogState();
}

class _ProfileEditDialogState extends State<ProfileEditDialog> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController universityController;
  late final TextEditingController departmentController;
  late final TextEditingController semesterController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.profile?['name'] as String? ?? '',
    );
    universityController = TextEditingController(
      text: widget.profile?['university'] as String? ?? '',
    );
    departmentController = TextEditingController(
      text: widget.profile?['department'] as String? ?? '',
    );
    semesterController = TextEditingController(
      text: widget.profile?['semester'] as String? ?? '',
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    universityController.dispose();
    departmentController.dispose();
    semesterController.dispose();
    super.dispose();
  }

  Widget _field(TextEditingController controller, String label) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextFormField(
      controller: controller,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(labelText: label),
      validator: (value) =>
          value == null || value.trim().isEmpty ? 'Enter $label' : null,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit profile'),
      content: SizedBox(
        width: 420,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _field(nameController, 'Student name'),
                _field(universityController, 'University'),
                _field(departmentController, 'Department or degree'),
                _field(semesterController, 'Semester'),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (!formKey.currentState!.validate()) return;
            Navigator.pop(context, <String, String>{
              'name': nameController.text.trim(),
              'university': universityController.text.trim(),
              'department': departmentController.text.trim(),
              'semester': semesterController.text.trim(),
            });
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

// ============================================================================
// MODULE 3: LIBRARY SEAT AVAILABILITY AND SLOT BOOKING
// ============================================================================


class LibraryTable {
  const LibraryTable(this.id, this.name, this.zone, this.capacity);

  final int id;
  final String name;
  final String zone;
  final int capacity;
}

const libraryTables = <LibraryTable>[
  LibraryTable(1, 'Quiet Table 1', 'Quiet zone', 4),
  LibraryTable(2, 'Quiet Table 2', 'Quiet zone', 4),
  LibraryTable(3, 'Group Table 1', 'Discussion zone', 6),
  LibraryTable(4, 'Group Table 2', 'Discussion zone', 6),
  LibraryTable(5, 'Window Desk 1', 'Single seats', 2),
  LibraryTable(6, 'Window Desk 2', 'Single seats', 2),
];

const _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

String _dateKey(DateTime d) =>
    '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

String _hourLabel(int hour) {
  final h = hour % 12 == 0 ? 12 : hour % 12;
  return '$h:00 ${hour >= 12 ? 'PM' : 'AM'}';
}

String _slotLabel(int hour) => '${_hourLabel(hour)} - ${_hourLabel(hour + 1)}';

String _longDate(DateTime d) =>
    '${_weekdays[d.weekday - 1]}, ${d.day} ${_months[d.month - 1]}';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  static const firstHour = 8; // first slot 8:00 AM
  static const lastHour = 19; // last slot 7:00 PM - 8:00 PM

  late final List<DateTime> days;
  int dayIndex = 0;
  int? selectedHour;
  bool loading = true;
  List<Map<String, Object?>> bookings = [];

  DateTime get selectedDay => days[dayIndex];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    days = List.generate(7, (i) => DateTime(now.year, now.month, now.day + i));
    selectedHour = _firstOpenHour(days.first);
    _load();
  }

  void _message(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  bool _isPast(DateTime day, int hour) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return day == today && hour <= now.hour;
  }

  int? _firstOpenHour(DateTime day) {
    for (var h = firstHour; h <= lastHour; h++) {
      if (!_isPast(day, h)) return h;
    }
    return null;
  }

  /// Demo data: pretends other students already use some seats.
  /// The same table/day/hour always gives the same number.
  int _simulatedTaken(LibraryTable table, DateTime day, int hour) {
    final seed = table.id * 31 + day.day * 17 + day.month * 13 + hour * 7;
    return seed % (table.capacity + 1);
  }

  int _mySeats(LibraryTable table, DateTime day, int hour) {
    final key = _dateKey(day);
    var total = 0;
    for (final booking in bookings) {
      if (booking['tableId'] == table.id &&
          booking['date'] == key &&
          booking['slotHour'] == hour) {
        total += booking['seats'] as int;
      }
    }
    return total;
  }

  int _freeSeats(LibraryTable table) {
    final hour = selectedHour;
    if (hour == null) return 0;
    final free =
        table.capacity -
        _simulatedTaken(table, selectedDay, hour) -
        _mySeats(table, selectedDay, hour);
    return free < 0 ? 0 : free;
  }

  Future<void> _load({bool showSpinner = true}) async {
    if (showSpinner) setState(() => loading = true);
    try {
      final rows = await DatabaseService.instance.getBookings();
      if (!mounted) return;
      setState(() {
        bookings = rows;
        loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => loading = false);
      _message('Could not load bookings: $error');
    }
  }

  void _selectDay(int index) {
    setState(() {
      dayIndex = index;
      final hour = selectedHour;
      if (hour == null || _isPast(days[index], hour)) {
        selectedHour = _firstOpenHour(days[index]);
      }
    });
  }

  Future<void> _book(LibraryTable table, int free) async {
    final hour = selectedHour;
    if (hour == null) {
      _message('Choose a time slot first.');
      return;
    }
    final key = _dateKey(selectedDay);
    final alreadyBooked = bookings.any(
      (b) => b['date'] == key && b['slotHour'] == hour,
    );
    if (alreadyBooked) {
      _message('You already have a booking at this time. Cancel it first.');
      return;
    }

    final booked = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (_) => _BookingSheet(
        table: table,
        day: selectedDay,
        hour: hour,
        maxSeats: free,
      ),
    );
    if (booked == true) {
      await _load(showSpinner: false);
      _message('Booked ${table.name} for ${_slotLabel(hour)}.');
    }
  }

  Future<void> _cancelBooking(Map<String, Object?> booking) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel this booking?'),
        content: Text(
          '${booking['tableName']} on ${_longDate(DateTime.parse(booking['date'] as String))}, '
          '${_slotLabel(booking['slotHour'] as int)}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep it'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Cancel booking'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await DatabaseService.instance.deleteBooking(booking['id'] as int);
      await _load(showSpinner: false);
      _message('Booking cancelled.');
    } catch (error) {
      _message('Could not cancel booking: $error');
    }
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: const TextStyle(
        color: deepPurple,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
    ),
  );

  String _dayChipLabel(int index) {
    if (index == 0) return 'Today';
    if (index == 1) return 'Tomorrow';
    final d = days[index];
    return '${_weekdays[d.weekday - 1]} ${d.day}';
  }

  Widget _tableCard(LibraryTable table) {
    final free = _freeSeats(table);
    final used = table.capacity - free;
    final Color statusColor = free == 0
        ? Colors.red
        : (free == 1 ? Colors.orange : green);
    return Card(
      color: Colors.white,
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: lilac,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.event_seat_rounded, color: purple),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    table.name,
                    style: const TextStyle(
                      color: deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    table.zone,
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: used / table.capacity,
                      minHeight: 7,
                      backgroundColor: const Color(0xFFEDEAF7),
                      color: statusColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    free == 0
                        ? 'Full'
                        : '$free of ${table.capacity} seats free',
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            FilledButton(
              onPressed: free > 0 && selectedHour != null
                  ? () => _book(table, free)
                  : null,
              child: const Text('Book'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _availabilityTab() {
    final hour = selectedHour;
    final totalFree = hour == null
        ? 0
        : libraryTables.fold<int>(0, (sum, t) => sum + _freeSeats(t));
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
      children: [
        _label('Choose a day'),
        SizedBox(
          height: 42,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: days.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, index) => ChoiceChip(
              label: Text(_dayChipLabel(index)),
              selected: dayIndex == index,
              onSelected: (_) => _selectDay(index),
              selectedColor: purple,
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                color: dayIndex == index ? Colors.white : deepPurple,
                fontWeight: FontWeight.w600,
              ),
              side: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _label('Choose a time slot'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (var h = firstHour; h <= lastHour; h++)
              ChoiceChip(
                label: Text(_hourLabel(h)),
                selected: selectedHour == h,
                onSelected: _isPast(selectedDay, h)
                    ? null
                    : (_) => setState(() => selectedHour = h),
                selectedColor: purple,
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                  color: selectedHour == h ? Colors.white : deepPurple,
                  fontWeight: FontWeight.w600,
                ),
                side: BorderSide.none,
              ),
          ],
        ),
        const SizedBox(height: 18),
        if (loading)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(child: CircularProgressIndicator(color: purple)),
          )
        else if (hour == null)
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Text(
              'No more slots are open today. Choose another day.',
              style: TextStyle(color: Colors.black54),
            ),
          )
        else ...[
          Container(
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [purple, Color(0xFF8B78FF)],
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Icon(Icons.local_library_rounded, color: Colors.white),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '${_longDate(selectedDay)} • ${_slotLabel(hour)}\n'
                    '$totalFree seats free in total',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...libraryTables.map(_tableCard),
          const SizedBox(height: 4),
          const Text(
            'Demo data: seats used by other students are simulated. Your own bookings are saved on this device.',
            style: TextStyle(color: Colors.black54, fontSize: 12, height: 1.4),
          ),
        ],
      ],
    );
  }

  Widget _bookingsTab() {
    if (loading && bookings.isEmpty) {
      return const Center(child: CircularProgressIndicator(color: purple));
    }
    if (bookings.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Text(
            'No bookings yet.\nPick a day, a slot and a table to reserve a seat.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, height: 1.5),
          ),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
      itemCount: bookings.length,
      itemBuilder: (_, index) {
        final booking = bookings[index];
        final day = DateTime.parse(booking['date'] as String);
        final hour = booking['slotHour'] as int;
        final past = DateTime(
          day.year,
          day.month,
          day.day,
          hour + 1,
        ).isBefore(DateTime.now());
        final seats = booking['seats'] as int;
        return Card(
          color: Colors.white,
          elevation: 1,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
            leading: Icon(
              past ? Icons.history_rounded : Icons.event_available_rounded,
              color: past ? Colors.black38 : green,
              size: 30,
            ),
            title: Text(
              booking['tableName'] as String,
              style: const TextStyle(
                color: deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '${_longDate(day)} • ${_slotLabel(hour)}\n'
              '$seats ${seats == 1 ? 'seat' : 'seats'}${past ? ' • Past' : ''}',
              style: const TextStyle(height: 1.4),
            ),
            isThreeLine: true,
            trailing: IconButton(
              tooltip: 'Cancel booking',
              onPressed: () => _cancelBooking(booking),
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Library Slots',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            labelColor: purple,
            unselectedLabelColor: Colors.black54,
            indicatorColor: purple,
            tabs: [
              const Tab(text: 'Availability'),
              Tab(text: 'My bookings (${bookings.length})'),
            ],
          ),
        ),
        body: TabBarView(children: [_availabilityTab(), _bookingsTab()]),
      ),
    );
  }
}

class _BookingSheet extends StatefulWidget {
  const _BookingSheet({
    required this.table,
    required this.day,
    required this.hour,
    required this.maxSeats,
  });

  final LibraryTable table;
  final DateTime day;
  final int hour;
  final int maxSeats;

  @override
  State<_BookingSheet> createState() => _BookingSheetState();
}

class _BookingSheetState extends State<_BookingSheet> {
  int seats = 1;
  bool saving = false;
  String? error;

  Future<void> _confirm() async {
    if (seats < 1 || seats > widget.maxSeats) {
      setState(() => error = 'Choose between 1 and ${widget.maxSeats} seats.');
      return;
    }
    setState(() {
      saving = true;
      error = null;
    });
    try {
      await DatabaseService.instance.addBooking(
        tableId: widget.table.id,
        tableName: widget.table.name,
        date: _dateKey(widget.day),
        slotHour: widget.hour,
        seats: seats,
      );
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        saving = false;
        error = 'Could not book this slot: $e';
      });
    }
  }

  Widget _row(IconData icon, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        Icon(icon, size: 19, color: purple),
        const SizedBox(width: 10),
        Expanded(child: Text(text)),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          22,
          8,
          22,
          22 + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Book ${widget.table.name}',
              style: const TextStyle(
                color: deepPurple,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            _row(Icons.calendar_month_outlined, _longDate(widget.day)),
            _row(Icons.access_time, _slotLabel(widget.hour)),
            _row(
              Icons.event_seat_outlined,
              '${widget.maxSeats} seats free at this table',
            ),
            const SizedBox(height: 10),
            const Text(
              'How many seats do you need?',
              style: TextStyle(color: deepPurple, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton.filledTonal(
                  onPressed: saving || seats <= 1
                      ? null
                      : () => setState(() => seats--),
                  icon: const Icon(Icons.remove),
                ),
                Expanded(
                  child: Text(
                    '$seats',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: deepPurple,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton.filledTonal(
                  onPressed: saving || seats >= widget.maxSeats
                      ? null
                      : () => setState(() => seats++),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            if (error != null) ...[
              const SizedBox(height: 8),
              Text(error!, style: const TextStyle(color: Colors.red)),
            ],
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton.icon(
                onPressed: saving ? null : _confirm,
                icon: saving
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.check_rounded),
                label: Text(saving ? 'Booking...' : 'Confirm booking'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// MODULE 3: GROUP CHAT LIST AND CHAT SCREEN
// ============================================================================


String _chatTime(DateTime t) {
  final now = DateTime.now();
  final sameDay = t.year == now.year && t.month == now.month && t.day == now.day;
  if (!sameDay) return '${t.day}/${t.month}';
  final hour = t.hour % 12 == 0 ? 12 : t.hour % 12;
  final minute = t.minute.toString().padLeft(2, '0');
  return '$hour:$minute ${t.hour >= 12 ? 'PM' : 'AM'}';
}

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key, this.refreshToken = 0});

  /// Change this value to make the list reload (e.g. when the tab is opened).
  final int refreshToken;

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  bool loading = true;
  List<Map<String, Object?>> groups = [];
  Map<int, Map<String, Object?>> lastMessages = {};
  String query = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant ChatListScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.refreshToken != widget.refreshToken) {
      _load(showSpinner: false);
    }
  }

  Future<void> _load({bool showSpinner = true}) async {
    if (showSpinner) setState(() => loading = true);
    try {
      final rows = await DatabaseService.instance.getGroups();
      final last = await DatabaseService.instance.getLastMessages();
      // Groups with the newest messages come first.
      rows.sort((a, b) {
        final aTime = last[a['id'] as int]?['sentAt'] as DateTime?;
        final bTime = last[b['id'] as int]?['sentAt'] as DateTime?;
        if (aTime == null && bTime == null) return 0;
        if (aTime == null) return 1;
        if (bTime == null) return -1;
        return bTime.compareTo(aTime);
      });
      if (!mounted) return;
      setState(() {
        groups = rows;
        lastMessages = last;
        loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => loading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not load chats: $error')));
    }
  }

  Future<void> _openChat(Map<String, Object?> group) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatScreen(
          groupId: group['id'] as int,
          groupName: group['name'] as String,
        ),
      ),
    );
    if (mounted) _load(showSpinner: false);
  }

  @override
  Widget build(BuildContext context) {
    final visible = groups.where((g) {
      if (query.trim().isEmpty) return true;
      return (g['name'] as String).toLowerCase().contains(
        query.trim().toLowerCase(),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Group Chats',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator(color: purple))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
                  child: TextField(
                    onChanged: (value) => setState(() => query = value),
                    decoration: const InputDecoration(
                      hintText: 'Search chats...',
                      prefixIcon: Icon(Icons.search, color: purple),
                    ),
                  ),
                ),
                Expanded(
                  child: visible.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Text(
                              groups.isEmpty
                                  ? 'No chats yet.\nCreate a study group to start chatting.'
                                  : 'No chats match your search.',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black54,
                                height: 1.5,
                              ),
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(14, 2, 14, 100),
                          itemCount: visible.length,
                          itemBuilder: (_, index) {
                            final group = visible[index];
                            final last = lastMessages[group['id'] as int];
                            return Card(
                              color: Colors.white,
                              elevation: 1,
                              margin: const EdgeInsets.only(bottom: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: ListTile(
                                onTap: () => _openChat(group),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 6,
                                ),
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: lilac,
                                  child: Text(
                                    (group['name'] as String).isEmpty
                                        ? '?'
                                        : (group['name'] as String)[0]
                                              .toUpperCase(),
                                    style: const TextStyle(
                                      color: purple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  group['name'] as String,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: deepPurple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  last == null
                                      ? 'No messages yet. Say hi!'
                                      : last['body'] as String,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: last == null
                                    ? null
                                    : Text(
                                        _chatTime(last['sentAt'] as DateTime),
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 11,
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.groupId, required this.groupName});

  final int groupId;
  final String groupName;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final textController = TextEditingController();
  final scrollController = ScrollController();
  List<Map<String, Object?>> messages = [];
  String senderName = 'Me';
  bool loading = true;
  bool sending = false;
  String? inputError;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) return;
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _load() async {
    try {
      final profile = await DatabaseService.instance.getProfile();
      final rows = await DatabaseService.instance.getMessages(widget.groupId);
      final name = (profile?['name'] as String?)?.trim() ?? '';
      if (!mounted) return;
      setState(() {
        senderName = name.isEmpty ? 'Me' : name;
        messages = rows;
        loading = false;
      });
      _scrollToBottom();
    } catch (error) {
      if (!mounted) return;
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not load messages: $error')),
      );
    }
  }

  Future<void> _send() async {
    if (sending) return;
    final text = textController.text.trim();
    if (text.isEmpty) {
      setState(() => inputError = 'Type a message first');
      return;
    }
    if (text.length > 500) {
      setState(() => inputError = 'Message is too long (max 500 characters)');
      return;
    }
    setState(() {
      sending = true;
      inputError = null;
    });
    try {
      await DatabaseService.instance.addMessage(
        groupId: widget.groupId,
        sender: senderName,
        body: text,
      );
      final rows = await DatabaseService.instance.getMessages(widget.groupId);
      if (!mounted) return;
      textController.clear();
      setState(() {
        messages = rows;
        sending = false;
      });
      _scrollToBottom();
    } catch (error) {
      if (!mounted) return;
      setState(() => sending = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not send message: $error')),
      );
    }
  }

  Widget _bubble(Map<String, Object?> message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.fromLTRB(14, 9, 14, 8),
        decoration: const BoxDecoration(
          color: purple,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(4),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message['sender'] as String,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              message['body'] as String,
              style: const TextStyle(color: Colors.white, height: 1.35),
            ),
            const SizedBox(height: 3),
            Text(
              _chatTime(message['sentAt'] as DateTime),
              style: const TextStyle(color: Colors.white60, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.groupName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator(color: purple))
                : messages.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        'No messages yet.\nSend the first message to your study group!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54, height: 1.5),
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                    itemCount: messages.length,
                    itemBuilder: (_, index) => _bubble(messages[index]),
                  ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            child: Text(
              'Demo chat: messages are saved on this device only.',
              style: TextStyle(color: Colors.black45, fontSize: 11),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      minLines: 1,
                      maxLines: 4,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (_) {
                        if (inputError != null) {
                          setState(() => inputError = null);
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Write a message...',
                        errorText: inputError,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: purple,
                        fixedSize: const Size(50, 50),
                      ),
                      onPressed: sending ? null : _send,
                      icon: sending
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.send_rounded),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// MODULE 3: GROUP FILTER (SUBJECT AND TIME)
// ============================================================================


enum TimeFilter { any, today, week, morning, afternoon, evening }

extension TimeFilterLabel on TimeFilter {
  String get label {
    switch (this) {
      case TimeFilter.any:
        return 'Any time';
      case TimeFilter.today:
        return 'Today';
      case TimeFilter.week:
        return 'Next 7 days';
      case TimeFilter.morning:
        return 'Morning (before 12 PM)';
      case TimeFilter.afternoon:
        return 'Afternoon (12 - 5 PM)';
      case TimeFilter.evening:
        return 'Evening (after 5 PM)';
    }
  }
}

bool matchesTimeFilter(DateTime value, TimeFilter filter) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final day = DateTime(value.year, value.month, value.day);
  switch (filter) {
    case TimeFilter.any:
      return true;
    case TimeFilter.today:
      return day == today;
    case TimeFilter.week:
      return !day.isBefore(today) &&
          day.isBefore(today.add(const Duration(days: 7)));
    case TimeFilter.morning:
      return value.hour < 12;
    case TimeFilter.afternoon:
      return value.hour >= 12 && value.hour < 17;
    case TimeFilter.evening:
      return value.hour >= 17;
  }
}

class GroupFilterResult {
  const GroupFilterResult(this.subject, this.time);

  final String subject;
  final TimeFilter time;
}

Future<GroupFilterResult?> showGroupFilterSheet(
  BuildContext context, {
  required List<String> subjects,
  required String subject,
  required TimeFilter time,
}) {
  return showModalBottomSheet<GroupFilterResult>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: Colors.white,
    builder: (_) =>
        _FilterSheet(subjects: subjects, subject: subject, time: time),
  );
}

class _FilterSheet extends StatefulWidget {
  const _FilterSheet({
    required this.subjects,
    required this.subject,
    required this.time,
  });

  final List<String> subjects;
  final String subject;
  final TimeFilter time;

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late String subject;
  late TimeFilter time;

  @override
  void initState() {
    super.initState();
    // If the saved subject no longer exists (group deleted), fall back to All.
    subject = widget.subjects.contains(widget.subject)
        ? widget.subject
        : 'All';
    time = widget.time;
  }

  Widget _title(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8, top: 4),
    child: Text(
      text,
      style: const TextStyle(
        color: deepPurple,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
    ),
  );

  Widget _chip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) => ChoiceChip(
    label: Text(label),
    selected: selected,
    onSelected: (_) => onTap(),
    selectedColor: purple,
    backgroundColor: const Color(0xFFF6F4FF),
    labelStyle: TextStyle(
      color: selected ? Colors.white : deepPurple,
      fontWeight: FontWeight.w600,
    ),
    side: BorderSide.none,
  );

  @override
  Widget build(BuildContext context) {
    final subjectOptions = ['All', ...widget.subjects];
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 4, 22, 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter study groups',
              style: TextStyle(
                color: deepPurple,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            _title('Subject'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final option in subjectOptions)
                  _chip(
                    label: option,
                    selected: subject == option,
                    onTap: () => setState(() => subject = option),
                  ),
              ],
            ),
            const SizedBox(height: 14),
            _title('Meeting time'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final option in TimeFilter.values)
                  _chip(
                    label: option.label,
                    selected: time == option,
                    onTap: () => setState(() => time = option),
                  ),
              ],
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => setState(() {
                      subject = 'All';
                      time = TimeFilter.any;
                    }),
                    child: const Text('Reset'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: FilledButton(
                    onPressed: () =>
                        Navigator.pop(context, GroupFilterResult(subject, time)),
                    child: const Text('Apply filters'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// MODULE 3: PROFILE BADGES
// ============================================================================


class _Badge {
  const _Badge({
    required this.title,
    required this.description,
    required this.icon,
    required this.current,
    required this.target,
  });

  final String title;
  final String description;
  final IconData icon;
  final int current;
  final int target;

  bool get earned => current >= target;
}

class ProfileBadges extends StatefulWidget {
  const ProfileBadges({
    super.key,
    required this.groupCount,
    this.refreshToken = 0,
  });

  final int groupCount;

  /// Change this value to make the badges reload their counts.
  final int refreshToken;

  @override
  State<ProfileBadges> createState() => _ProfileBadgesState();
}

class _ProfileBadgesState extends State<ProfileBadges> {
  bool loading = true;
  int bookingCount = 0;
  int messageCount = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant ProfileBadges oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.refreshToken != widget.refreshToken) _load();
  }

  Future<void> _load() async {
    try {
      final bookings = await DatabaseService.instance.getBookingCount();
      final messages = await DatabaseService.instance.getMessageCount();
      if (!mounted) return;
      setState(() {
        bookingCount = bookings;
        messageCount = messages;
        loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => loading = false);
    }
  }

  List<_Badge> get _badges => [
    _Badge(
      title: 'First Group',
      description: 'Create your first study group',
      icon: Icons.groups_rounded,
      current: widget.groupCount,
      target: 1,
    ),
    _Badge(
      title: 'Group Builder',
      description: 'Create 3 study groups',
      icon: Icons.diversity_3_rounded,
      current: widget.groupCount,
      target: 3,
    ),
    _Badge(
      title: 'Library Regular',
      description: 'Book your first library slot',
      icon: Icons.local_library_rounded,
      current: bookingCount,
      target: 1,
    ),
    _Badge(
      title: 'Study Planner',
      description: 'Make 3 library bookings',
      icon: Icons.event_available_rounded,
      current: bookingCount,
      target: 3,
    ),
    _Badge(
      title: 'Chat Starter',
      description: 'Send your first group message',
      icon: Icons.chat_bubble_rounded,
      current: messageCount,
      target: 1,
    ),
    _Badge(
      title: 'Active Chatter',
      description: 'Send 10 group messages',
      icon: Icons.forum_rounded,
      current: messageCount,
      target: 10,
    ),
  ];

  String _level(int earned) {
    if (earned >= 5) return 'Study Star';
    if (earned >= 2) return 'Active Pal';
    return 'Newcomer';
  }

  Widget _badgeTile(_Badge badge) {
    final earned = badge.earned;
    final shown = badge.current > badge.target ? badge.target : badge.current;
    return Tooltip(
      message: badge.description,
      child: SizedBox(
        width: 92,
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: earned ? lilac : const Color(0xFFF0F0F3),
                border: Border.all(
                  color: earned ? purple : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Icon(
                badge.icon,
                color: earned ? purple : Colors.black26,
                size: 28,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              badge.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                color: earned ? deepPurple : Colors.black45,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              earned ? 'Earned' : '$shown/${badge.target}',
              style: TextStyle(
                color: earned ? green : Colors.black38,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final badges = _badges;
    final earned = badges.where((b) => b.earned).length;
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.stars_rounded, color: purple),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Profile badges',
                    style: TextStyle(
                      color: deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: lilac,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    _level(earned),
                    style: const TextStyle(
                      color: purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '$earned of ${badges.length} badges earned',
              style: const TextStyle(color: Colors.black54, fontSize: 12),
            ),
            const SizedBox(height: 10),
            if (loading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(child: CircularProgressIndicator(color: purple)),
              )
            else
              Wrap(
                spacing: 6,
                runSpacing: 14,
                alignment: WrapAlignment.spaceBetween,
                children: badges.map(_badgeTile).toList(),
              ),
          ],
        ),
      ),
    );
  }
}