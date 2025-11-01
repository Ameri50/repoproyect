import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mentoria/providers/theme_provider.dart';
import 'dashboard_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final Map<String, Map<String, String>> texts = {
    'es': {
      'appName': 'MentorIA',
      'tagline': 'Tu compañero inteligente de progreso',
      'quote': '"El éxito no es final, el fracaso no es fatal: es el coraje para continuar lo que cuenta."',
      'buttonText': 'Comienza tu camino',
    },
    'en': {
      'appName': 'MentorIA',
      'tagline': 'Your intelligent progress companion',
      'quote': '"Success is not final, failure is not fatal: it is the courage to continue that counts."',
      'buttonText': 'Start your journey',
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

        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: isDarkMode
                  ? const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF0a0e27),
                        Color(0xFF6a4c93),
                      ],
                    )
                  : const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF0b1e6b),
                        Color(0xFF8b5cf6),
                      ],
                    ),
            ),
            child: Stack(
              children: [
                // Background particles (simulated with Rive or simple animations)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage('assets/images/particles.png'),
                        fit: BoxFit.cover,
                        opacity: isDarkMode ? 0.05 : 0.1,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // App Logo/Icon
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: isDarkMode
                                ? const [Color(0xFF9d7ce9), Color(0xFF06b6d4)]
                                : const [Color(0xFF8b5cf6), Color(0xFF06b6d4)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF8b5cf6)
                                  .withValues(alpha: isDarkMode ? 0.3 : 0.5),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.lightbulb_outline,
                          size: 60,
                          color: Colors.white,
                        ),
                      ).animate().scale(duration: 800.ms, curve: Curves.elasticOut),
                      const SizedBox(height: 40),
                      // App Title
                      Text(
                        getText('appName', selectedLanguage),
                        style: GoogleFonts.poppins(
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                      const SizedBox(height: 10),
                      Text(
                        getText('tagline', selectedLanguage),
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
                      const SizedBox(height: 60),
                      // Motivational Quote
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: isDarkMode
                                  ? Colors.white.withValues(alpha: 0.08)
                                  : Colors.white.withValues(alpha: 0.1),
                            ),
                            child: Text(
                              getText('quote', selectedLanguage),
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ).animate()
                          .slideY(begin: 0.5, duration: 800.ms, delay: 600.ms),
                      const SizedBox(height: 60),
                      // Start Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation,
                                      secondaryAnimation) =>
                                  const DashboardScreen(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.easeInOut;
                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF06b6d4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 10,
                          shadowColor: const Color(0xFF06b6d4)
                              .withValues(alpha: 0.5),
                        ),
                        child: Text(
                          getText('buttonText', selectedLanguage),
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ).animate().scale(duration: 600.ms, delay: 800.ms),
                      const SizedBox(height: 40),
                      // Theme and Language Indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Theme Toggle Indicator
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withValues(alpha: 0.15),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isDarkMode ? Icons.dark_mode : Icons.light_mode,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  isDarkMode
                                      ? (selectedLanguage == 'es'
                                          ? 'Oscuro'
                                          : 'Dark')
                                      : (selectedLanguage == 'es'
                                          ? 'Claro'
                                          : 'Light'),
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Language Indicator
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withValues(alpha: 0.15),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.language,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  selectedLanguage == 'es' ? 'Español' : 'English',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ).animate()
                          .fadeIn(duration: 600.ms, delay: 1000.ms),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}