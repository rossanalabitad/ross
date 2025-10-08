import 'package:flutter/material.dart';

class SkillGrid extends StatelessWidget {
  final ThemeMode themeMode;
  const SkillGrid({super.key, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    final skills = [
      (Icons.phone_android, "Flutter & Dart", "Mobile Development", 0.30),
      (Icons.cloud, "JavaScript", "Backend Services", 0.30),
      (Icons.link, "CSS", "Design", 0.70),
      (Icons.code, "Git & GitHub", "Version Control", 0.60),
      (Icons.design_services, "HTML", "Integration", 0.20),
      (Icons.storage, "SQLite", "Database", 0.60),
      (Icons.cloud_queue, "Node.js", "Backend", 0.50),
      (Icons.bug_report, "Python", "Programming", 0.50),
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: skills
          .map(
            (s) => SkillCard(
              icon: s.$1,
              skill: s.$2,
              role: s.$3,
              level: s.$4,
              themeMode: themeMode,
            ),
          )
          .toList(),
    );
  }
}

class SkillCard extends StatelessWidget {
  final IconData icon;
  final String skill, role;
  final double level;
  final ThemeMode themeMode;

  const SkillCard({
    super.key,
    required this.icon,
    required this.skill,
    required this.role,
    required this.level,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = themeMode == ThemeMode.dark;
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 180,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.1),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.blue, size: 28),
            const SizedBox(height: 10),
            Text(
              skill,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            Text(
              role,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: level,
                backgroundColor: isDark ? Colors.white12 : Colors.grey.shade300,
                color: Colors.blueAccent,
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${(level * 100).toInt()}%",
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
