import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  final ThemeMode themeMode;

  const ProfileSection({super.key, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    final isDark = themeMode == ThemeMode.dark;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: isDark
              ? const LinearGradient(
                  colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isDark ? null : Colors.white,
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile picture
            const CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage('assets/ross.jpg'),
            ),
            const SizedBox(height: 20),

            // Name
            Text(
              'Rossana C. Labitad',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 10),

            // Education / title chip
            Chip(
              backgroundColor: isDark
                  ? Colors.blue.shade800
                  : Colors.blue.shade100,
              label: const Text(
                'BS Information Technology • 3rd Year',
                style: TextStyle(color: Color.fromARGB(255, 26, 158, 147)),
              ),
            ),

            const SizedBox(height: 20),

            // Short description
            Text(
              'Enjoying life to the fullest',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.5,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),

            const SizedBox(height: 30),

            // Contact info
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 30,
              runSpacing: 10,
              children: const [
                _ContactItem(Icons.email, 'labitadrossana21@gmail.com'),
                _ContactItem(Icons.phone, '+63 991-9241-074'),
                _ContactItem(Icons.location_on, 'Dayawan, Villanueva, Mis.or'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Contact info item widget
class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContactItem(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.blue, size: 22),
        const SizedBox(height: 4),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}
