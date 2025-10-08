import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectGrid extends StatelessWidget {
  final ThemeMode themeMode;

  const ProjectGrid({super.key, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive card width
        double cardWidth;
        if (constraints.maxWidth < 600) {
          cardWidth = constraints.maxWidth;
        } else if (constraints.maxWidth < 1000) {
          cardWidth = (constraints.maxWidth - 16) / 2;
        } else {
          cardWidth = (constraints.maxWidth - 32) / 3;
        }

        // Project data list
        final projects = [
          (
            'assets/rossana.png',
            'Completed',
            '2 weeks',
            'Flutter Portfolio',
            'A Flutter portfolio.',
            ['Flutter', 'Dart'],
            'https://github.com/rossanalabitad/ross',
          ),
        ];

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: projects
              .map(
                (p) => ProjectCard(
                  width: cardWidth,
                  imagePath: p.$1,
                  status: p.$2,
                  timeAgo: p.$3,
                  title: p.$4,
                  description: p.$5,
                  tags: p.$6,
                  githubUrl: p.$7,
                  themeMode: themeMode,
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class ProjectCard extends StatefulWidget {
  final double width;
  final String imagePath, status, timeAgo, title, description, githubUrl;
  final List<String> tags;
  final ThemeMode themeMode;

  const ProjectCard({
    super.key,
    required this.width,
    required this.imagePath,
    required this.status,
    required this.timeAgo,
    required this.title,
    required this.description,
    required this.tags,
    required this.githubUrl,
    required this.themeMode,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;

  Future<void> _launchGitHub(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.themeMode == ThemeMode.dark;
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered
            ? (Matrix4.identity()..scale(1.02))
            : Matrix4.identity(),
        curve: Curves.easeOut,
        width: widget.width,
        child: Card(
          elevation: _isHovered ? 10 : 4,
          shadowColor: Colors.blue.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.asset(
                  widget.imagePath,
                  height: 150,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status + Duration Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(
                          label: Text(
                            widget.status,
                            style: TextStyle(
                              color: widget.status == 'Completed'
                                  ? Colors.green
                                  : Colors.orange,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          backgroundColor: widget.status == 'Completed'
                              ? Colors.green.shade100
                              : Colors.orange.shade100,
                        ),
                        Text(
                          widget.timeAgo,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: isDark ? Colors.white70 : Colors.black87,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Title
                    Text(
                      widget.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // Description
                    Text(
                      widget.description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        height: 1.4,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Tags
                    Wrap(
                      spacing: 6,
                      children: widget.tags
                          .map(
                            (t) => Chip(
                              label: Text(
                                t,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                ),
                              ),
                              backgroundColor: Colors.blue.shade50,
                            ),
                          )
                          .toList(),
                    ),

                    const SizedBox(height: 16),

                    // GitHub button
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () => _launchGitHub(widget.githubUrl),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.code, color: Colors.white),
                        label: const Text(
                          "View on GitHub",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
