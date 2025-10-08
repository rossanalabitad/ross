import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../sections/profile_section.dart';
import '../sections/project_section.dart';
import '../sections/skills_section.dart';
import '../sections/section.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;

  const HomePage({
    super.key,
    required this.onToggleTheme,
    required this.themeMode,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Scroll controller and keys for section navigation
  final _scrollController = ScrollController();
  final _profileKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _skillsKey = GlobalKey();

  // Smooth scroll to a section by key
  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  // Contact dialog (instead of snackbar)
  void _showContactDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Contact Me'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Feel free to reach out via email or social media!',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.mail, color: Colors.blue),
                SizedBox(width: 8),
                Text('youremail@example.com'),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top navigation bar
            Navbar(
              onProfile: () => _scrollTo(_profileKey),
              onProjects: () => _scrollTo(_projectsKey),
              onSkills: () => _scrollTo(_skillsKey),
              onToggleTheme: widget.onToggleTheme,
              themeMode: widget.themeMode,
              isMobile: isMobile,
            ),

            // Scrollable content sections
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Profile section
                    ProfileSection(
                      key: _profileKey,
                      themeMode: widget.themeMode,
                    ),

                    // Projects section
                    Section(
                      key: _projectsKey,
                      title: 'Featured Projects',
                      icon: Icons.work,
                      child: ProjectGrid(themeMode: widget.themeMode),
                    ),

                    // Skills section
                    Section(
                      key: _skillsKey,
                      title: 'Skills & Expertise',
                      icon: Icons.code,
                      child: SkillGrid(themeMode: widget.themeMode),
                    ),

                    const SizedBox(height: 40),

                    // Footer section
                    const Footer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Floating button for contact
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showContactDialog,
        label: const Text(
          "Contact Me",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.mail, color: Colors.white),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
