import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mentoria/providers/theme_provider.dart';

class RecommendationsScreen extends StatelessWidget {
  RecommendationsScreen({super.key});

  final List<Map<String, dynamic>> recommendations = const [
    {
      'title': 'Mejora tu Técnica de Estudio',
      'description': 'Aprende métodos efectivos para optimizar tu tiempo de estudio',
      'titleEn': 'Improve Your Study Technique',
      'descriptionEn': 'Learn effective methods to optimize your study time',
      'icon': Icons.lightbulb,
      'color': 0xFFFFB84D,
    },
    {
      'title': 'Gestión del Estrés',
      'description': 'Técnicas comprobadas para manejar la presión académica',
      'titleEn': 'Stress Management',
      'descriptionEn': 'Proven techniques to handle academic pressure',
      'icon': Icons.spa,
      'color': 0xFF4ECDC4,
    },
    {
      'title': 'Habilidades de Comunicación',
      'description': 'Mejora tus presentaciones y expresión oral',
      'titleEn': 'Communication Skills',
      'descriptionEn': 'Improve your presentations and speaking',
      'icon': Icons.mic,
      'color': 0xFF95E1D3,
    },
    {
      'title': 'Planificación Académica',
      'description': 'Organiza tus tareas y metas de forma efectiva',
      'titleEn': 'Academic Planning',
      'descriptionEn': 'Organize your tasks and goals effectively',
      'icon': Icons.calendar_today,
      'color': 0xFF6C5CE7,
    },
    {
      'title': 'Colaboración y Trabajo en Equipo',
      'description': 'Estrategias para trabajar mejor en grupos',
      'titleEn': 'Collaboration and Teamwork',
      'descriptionEn': 'Strategies for better group work',
      'icon': Icons.people,
      'color': 0xFF00B894,
    },
    {
      'title': 'Desarrollo de Liderazgo',
      'description': 'Conviértete en un líder efectivo',
      'titleEn': 'Leadership Development',
      'descriptionEn': 'Become an effective leader',
      'icon': Icons.trending_up,
      'color': 0xFFFF7675,
    },
  ];

  final Map<String, Map<String, String>> texts = {
    'es': {
      'title': 'Recomendaciones',
      'subtitle': 'Mejora tu desempeño académico',
    },
    'en': {
      'title': 'Recommendations',
      'subtitle': 'Improve your academic performance',
    },
  };

  String getText(String key, String language) {
    return texts[language]?[key] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        final isDarkMode = themeProvider.isDarkMode;
        final selectedLanguage = themeProvider.selectedLanguage;
        final bgColor = isDarkMode ? const Color(0xFF1a1a1a) : Colors.white;
        final textColor = isDarkMode ? Colors.white : const Color(0xFF0b1e6b);
        final subtextColor = isDarkMode ? Colors.grey[400] : Colors.grey;

        return Container(
          color: bgColor,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getText('title', selectedLanguage),
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: textColor,
                              ),
                            ),
                            Text(
                              getText('subtitle', selectedLanguage),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: subtextColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.notifications_none),
                              color: isDarkMode ? Colors.grey[400] : Colors.grey,
                            ),
                            ClipOval(
                              child: Image.network(
                                'https://api.dicebear.com/7.x/avataaars/svg?seed=Felix',
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF8b5cf6),
                                          Color(0xFF06b6d4)
                                        ],
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 600.ms),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.85,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: recommendations.length,
                      itemBuilder: (context, index) {
                        final rec = recommendations[index];
                        return _buildRecommendationCard(
                          rec,
                          index,
                          isDarkMode,
                          textColor,
                          selectedLanguage,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecommendationCard(
    Map<String, dynamic> rec,
    int index,
    bool isDarkMode,
    Color textColor,
    String selectedLanguage,
  ) {
    final title = selectedLanguage == 'es' ? rec['title'] : rec['titleEn'];
    final description =
        selectedLanguage == 'es' ? rec['description'] : rec['descriptionEn'];
    final cardColor = Color(rec['color']);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isDarkMode
            ? cardColor.withValues(alpha: 0.15)
            : cardColor.withValues(alpha: 0.1),
        border: Border.all(
          color: isDarkMode
              ? cardColor.withValues(alpha: 0.4)
              : cardColor.withValues(alpha: 0.3),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cardColor,
                  ),
                  child: Icon(
                    rec['icon'],
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().slideY(
      begin: 0.3,
      duration: 600.ms,
      delay: Duration(milliseconds: 300 + (index * 100)),
    );
  }
}