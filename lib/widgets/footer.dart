import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'hover_icon_button.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  // Helper function to open URLs
  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      color: isDark ? const Color(0xFF121212) : const Color(0xFFF9F9F9),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 24,
            runSpacing: 12,
            children: [
              HoverIconButton(
                icon: Icons.code,
                label: "GitHub",
                iconColor: isDark ? Colors.white : Colors.black,
                onPressed: () => _openUrl("https://github.com/rossanalabitad"),
              ),
              HoverIconButton(
                icon: Icons.business,
                label: "LinkedIn",
                iconColor: Colors.blueAccent,
                onPressed: () =>
                    _openUrl("https://www.linkedin.com/in/your-profile"),
              ),
              HoverIconButton(
                icon: Icons.email,
                label: "Email",
                iconColor: Colors.redAccent,
                onPressed: () => _openUrl("mailto:labitadrossana21@gmail.com "),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(
            color: isDark ? Colors.white24 : Colors.black12,
            thickness: 1,
            indent: 60,
            endIndent: 60,
          ),
          const SizedBox(height: 8),
          Text(
            '© 2025 My Portfolio. All rights reserved.',
            style: TextStyle(
              color: isDark ? Colors.white70 : Colors.black87,
              fontSize: 12,
              letterSpacing: 0.3,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
