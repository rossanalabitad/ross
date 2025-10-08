import 'package:flutter/material.dart';
import 'theme_toggle.dart';

class Navbar extends StatefulWidget {
  final VoidCallback onProfile;
  final VoidCallback onProjects;
  final VoidCallback onSkills;
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;
  final bool isMobile;

  const Navbar({
    super.key,
    required this.onProfile,
    required this.onProjects,
    required this.onSkills,
    required this.onToggleTheme,
    required this.themeMode,
    required this.isMobile,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _activeIndex = 0;

  Widget _buildNavButton({
    required int index,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final isActive = _activeIndex == index;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: isActive
              ? Colors.blueAccent.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton.icon(
          onPressed: () {
            setState(() => _activeIndex = index);
            onTap();
          },
          icon: Icon(icon, color: Colors.white),
          label: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.blueAccent : Colors.white,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.themeMode == ThemeMode.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: isDark
          ? const Color.fromARGB(255, 181, 243, 205)
          : const Color.fromARGB(255, 88, 134, 102),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ✅ Left: Logo / Brand
          Row(
            children: const [
              Icon(Icons.account_circle, size: 36, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'My Portfolio',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          // ✅ Right Side
          Row(
            children: [
              if (!widget.isMobile) ...[
                _buildNavButton(
                  index: 0,
                  icon: Icons.person,
                  label: 'Profile',
                  onTap: widget.onProfile,
                ),
                _buildNavButton(
                  index: 1,
                  icon: Icons.work,
                  label: 'Projects',
                  onTap: widget.onProjects,
                ),
                _buildNavButton(
                  index: 2,
                  icon: Icons.code,
                  label: 'Skills',
                  onTap: widget.onSkills,
                ),
                const SizedBox(width: 12),
              ],

              ThemeToggle(
                onToggle: widget.onToggleTheme,
                themeMode: widget.themeMode,
              ),

              if (widget.isMobile) ...[
                const SizedBox(width: 8),
                PopupMenuButton<int>(
                  color: const Color.fromARGB(255, 43, 202, 96),
                  tooltip: 'Show menu',
                  onSelected: (value) {
                    setState(() => _activeIndex = value);
                    if (value == 0) widget.onProfile();
                    if (value == 1) widget.onProjects();
                    if (value == 2) widget.onSkills();
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem<int>(
                      value: 0,
                      child: Row(
                        children: [
                          Icon(Icons.person, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Profile',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: [
                          Icon(Icons.work, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Projects',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 2,
                      child: Row(
                        children: [
                          Icon(Icons.code, color: Colors.white),
                          SizedBox(width: 8),
                          Text('Skills', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                  child: const Icon(Icons.menu, color: Colors.white),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
