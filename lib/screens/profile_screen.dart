import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mentoria/providers/theme_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Map<String, Map<String, String>> texts = {
    'es': {
      'perfil': 'Perfil',
      'estudiante': 'Estudiante MentoriA',
      'email': 'estudiante@mentoria.com',
      'activo': 'Activo',
      'estadisticas': 'Estadísticas',
      'diasActivos': 'Días Activos',
      'tareas': 'Tareas',
      'logros': 'Logros',
      'preferencias': 'Preferencias',
      'notificaciones': 'Notificaciones',
      'notificacionesSub': 'Gestiona tus alertas',
      'privacidad': 'Privacidad',
      'privacidadSub': 'Controla tu información',
      'idioma': 'Idioma',
      'idiomaSub': 'Español',
      'apariencia': 'Apariencia',
      'aparienciaSub': 'Modo claro',
      'ayuda': 'Ayuda',
      'centroAyuda': 'Centro de Ayuda',
      'centroAyudaSub': 'Preguntas frecuentes',
      'comentarios': 'Enviar Comentarios',
      'comentariosSub': 'Cuéntanos tu experiencia',
      'acerca': 'Acerca de',
      'acercaSub': 'Versión 1.0.0',
      'cerrarSesion': 'Cerrar Sesión',
    },
    'en': {
      'perfil': 'Profile',
      'estudiante': 'MentoriA Student',
      'email': 'student@mentoria.com',
      'activo': 'Active',
      'estadisticas': 'Statistics',
      'diasActivos': 'Active Days',
      'tareas': 'Tasks',
      'logros': 'Achievements',
      'preferencias': 'Preferences',
      'notificaciones': 'Notifications',
      'notificacionesSub': 'Manage your alerts',
      'privacidad': 'Privacy',
      'privacidadSub': 'Control your information',
      'idioma': 'Language',
      'idiomaSub': 'English',
      'apariencia': 'Appearance',
      'aparienciaSub': 'Light mode',
      'ayuda': 'Help',
      'centroAyuda': 'Help Center',
      'centroAyudaSub': 'Frequently asked questions',
      'comentarios': 'Send Feedback',
      'comentariosSub': 'Tell us about your experience',
      'acerca': 'About',
      'acercaSub': 'Version 1.0.0',
      'cerrarSesion': 'Logout',
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
        final cardColor = isDarkMode ? const Color(0xFF2a2a2a) : Colors.grey[50];
        final borderColor = isDarkMode ? Colors.grey[700] : Colors.grey[200];

        return Container(
          color: bgColor,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getText('perfil', selectedLanguage),
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.settings),
                          color: isDarkMode ? Colors.grey[400] : Colors.grey,
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 600.ms),

                  // Avatar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: cardColor,
                        border: Border.all(color: borderColor!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.network(
                              'https://api.dicebear.com/7.x/avataaars/svg?seed=Felix',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 100,
                                  height: 100,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [Color(0xFF8b5cf6), Color(0xFF06b6d4)],
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            getText('estudiante', selectedLanguage),
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            getText('email', selectedLanguage),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.green[isDarkMode ? 900 : 100],
                            ),
                            child: Text(
                              getText('activo', selectedLanguage),
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.green[isDarkMode ? 400 : 700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().slideY(begin: 0.3, duration: 600.ms, delay: 100.ms),

                  const SizedBox(height: 30),

                  // Estadísticas
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getText('estadisticas', selectedLanguage),
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _buildStatCard(getText('diasActivos', selectedLanguage), '45', 0xFF8b5cf6, isDarkMode),
                            const SizedBox(width: 12),
                            _buildStatCard(getText('tareas', selectedLanguage), '28', 0xFF06b6d4, isDarkMode),
                            const SizedBox(width: 12),
                            _buildStatCard(getText('logros', selectedLanguage), '12', 0xFF00B894, isDarkMode),
                          ],
                        ),
                      ],
                    ),
                  ).animate().slideY(begin: 0.3, duration: 600.ms, delay: 200.ms),

                  const SizedBox(height: 30),

                  // Preferencias
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getText('preferencias', selectedLanguage),
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildMenuItem(
                          icon: Icons.notifications,
                          title: getText('notificaciones', selectedLanguage),
                          subtitle: getText('notificacionesSub', selectedLanguage),
                          onTap: () {},
                          isDarkMode: isDarkMode,
                          textColor: textColor,
                          cardColor: cardColor,
                          borderColor: borderColor,
                        ),
                        _buildMenuItem(
                          icon: Icons.privacy_tip,
                          title: getText('privacidad', selectedLanguage),
                          subtitle: getText('privacidadSub', selectedLanguage),
                          onTap: () {},
                          isDarkMode: isDarkMode,
                          textColor: textColor,
                          cardColor: cardColor,
                          borderColor: borderColor,
                        ),
                        _buildMenuItemLanguage(
                          icon: Icons.language,
                          title: getText('idioma', selectedLanguage),
                          subtitle: getText('idiomaSub', selectedLanguage),
                          isDarkMode: isDarkMode,
                          textColor: textColor,
                          cardColor: cardColor,
                          borderColor: borderColor,
                          themeProvider: themeProvider,
                        ),
                        _buildMenuItemAppearance(
                          icon: Icons.dark_mode,
                          title: getText('apariencia', selectedLanguage),
                          subtitle: isDarkMode ? 'Modo oscuro' : getText('aparienciaSub', selectedLanguage),
                          isDarkMode: isDarkMode,
                          textColor: textColor,
                          cardColor: cardColor,
                          borderColor: borderColor,
                          themeProvider: themeProvider,
                        ),
                      ],
                    ),
                  ).animate().slideY(begin: 0.3, duration: 600.ms, delay: 300.ms),

                  const SizedBox(height: 30),

                  // Ayuda y otros
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getText('ayuda', selectedLanguage),
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildMenuItem(
                          icon: Icons.help_center,
                          title: getText('centroAyuda', selectedLanguage),
                          subtitle: getText('centroAyudaSub', selectedLanguage),
                          onTap: () {},
                          isDarkMode: isDarkMode,
                          textColor: textColor,
                          cardColor: cardColor,
                          borderColor: borderColor,
                        ),
                        _buildMenuItem(
                          icon: Icons.feedback,
                          title: getText('comentarios', selectedLanguage),
                          subtitle: getText('comentariosSub', selectedLanguage),
                          onTap: () {},
                          isDarkMode: isDarkMode,
                          textColor: textColor,
                          cardColor: cardColor,
                          borderColor: borderColor,
                        ),
                        _buildMenuItem(
                          icon: Icons.info,
                          title: getText('acerca', selectedLanguage),
                          subtitle: getText('acercaSub', selectedLanguage),
                          onTap: () {},
                          isDarkMode: isDarkMode,
                          textColor: textColor,
                          cardColor: cardColor,
                          borderColor: borderColor,
                        ),
                      ],
                    ),
                  ).animate().slideY(begin: 0.3, duration: 600.ms, delay: 400.ms),

                  const SizedBox(height: 20),

                  // Botón de cerrar sesión
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDarkMode ? Colors.red[900] : Colors.red[50],
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: isDarkMode ? Colors.red[700]! : Colors.red[200]!,
                            ),
                          ),
                        ),
                        child: Text(
                          getText('cerrarSesion', selectedLanguage),
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.red[300] : Colors.red[700],
                          ),
                        ),
                      ),
                    ),
                  ).animate().scale(duration: 600.ms, delay: 500.ms),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatCard(String label, String value, int colorInt, bool isDarkMode) {
    final color = Color(colorInt);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color.withValues(alpha: isDarkMode ? 0.2 : 0.1),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isDarkMode,
    required Color textColor,
    required Color? cardColor,
    required Color? borderColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: cardColor,
          border: Border.all(color: borderColor!),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF8b5cf6).withValues(alpha: 0.1),
              ),
              child: Icon(icon, color: const Color(0xFF8b5cf6), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w600, color: textColor)),
                  Text(subtitle,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? Colors.grey[400] : Colors.grey[600])),
                ],
              ),
            ),
            Icon(Icons.chevron_right,
                color: isDarkMode ? Colors.grey[600] : Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItemLanguage({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isDarkMode,
    required Color textColor,
    required Color? cardColor,
    required Color? borderColor,
    required ThemeProvider themeProvider,
  }) {
    return GestureDetector(
      onTap: () => _showLanguageDialog(themeProvider),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: cardColor,
          border: Border.all(color: borderColor!),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF8b5cf6).withValues(alpha: 0.1),
              ),
              child: Icon(icon, color: const Color(0xFF8b5cf6), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w600, color: textColor)),
                  Text(subtitle,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? Colors.grey[400] : Colors.grey[600])),
                ],
              ),
            ),
            Icon(Icons.chevron_right,
                color: isDarkMode ? Colors.grey[600] : Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItemAppearance({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isDarkMode,
    required Color textColor,
    required Color? cardColor,
    required Color? borderColor,
    required ThemeProvider themeProvider,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: cardColor,
        border: Border.all(color: borderColor!),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF8b5cf6).withValues(alpha: 0.1),
            ),
            child: Icon(icon, color: const Color(0xFF8b5cf6), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w600, color: textColor)),
                Text(subtitle,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600])),
              ],
            ),
          ),
          Switch(
            value: isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
            activeThumbColor: const Color(0xFF8b5cf6),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(ThemeProvider themeProvider) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: themeProvider.isDarkMode ? const Color(0xFF2a2a2a) : Colors.white,
          title: Text('Seleccionar idioma',
              style: GoogleFonts.poppins(
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                value: 'es',
                groupValue: themeProvider.selectedLanguage,
                onChanged: (value) {
                  themeProvider.setLanguage(value!);
                  Navigator.pop(context);
                },
                title: Text('Español',
                    style: GoogleFonts.poppins(
                        color: themeProvider.isDarkMode ? Colors.white : Colors.black)),
              ),
              RadioListTile<String>(
                value: 'en',
                groupValue: themeProvider.selectedLanguage,
                onChanged: (value) {
                  themeProvider.setLanguage(value!);
                  Navigator.pop(context);
                },
                title: Text('English',
                    style: GoogleFonts.poppins(
                        color: themeProvider.isDarkMode ? Colors.white : Colors.black)),
              ),
            ],
          ),
        );
      },
    );
  }
}