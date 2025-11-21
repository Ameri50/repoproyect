import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mentoria/providers/theme_provider.dart';
import 'dashboard_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final Map<String, Map<String, String>> texts = {
    'es': {
      'appName': 'MentoriA',
      'tagline': 'Tu compañero inteligente de progreso',
      'quote':
          '"El éxito no es final, el fracaso no es fatal: es el coraje para continuar lo que cuenta."',
      'buttonText': 'Comienza tu camino',
      'description':
          'Aprende de mentores expertos, crece personalmente y alcanza tus metas académicas',
    },
    'en': {
      'appName': 'MentoriA',
      'tagline': 'Your intelligent progress companion',
      'quote':
          '"Success is not final, failure is not fatal: it is the courage to continue that counts."',
      'buttonText': 'Start your journey',
      'description':
          'Learn from expert mentors, grow personally and reach your academic goals',
    },
  };

  String getText(String key, String language) {
    return texts[language]?[key] ?? '';
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                        Color(0xFF1a0b3a),
                        Color(0xFF6a4c93),
                      ],
                      stops: [0.0, 0.5, 1.0],
                    )
                  : const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF0b1e6b),
                        Color(0xFF5b21b6),
                        Color(0xFF8b5cf6),
                      ],
                      stops: [0.0, 0.5, 1.0],
                    ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: ParticlePainter(
                          animationValue: _controller.value,
                          isDarkMode: isDarkMode,
                        ),
                      );
                    },
                  ),
                ),
                SafeArea(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height - 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: isDarkMode
                                        ? const [
                                            Color(0xFF9d7ce9),
                                            Color(0xFF06b6d4)
                                          ]
                                        : const [
                                            Color(0xFF8b5cf6),
                                            Color(0xFF06b6d4)
                                          ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF8b5cf6)
                                          .withOpacity(
                                              isDarkMode ? 0.4 : 0.6),
                                      blurRadius: 30,
                                      spreadRadius: 8,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.auto_awesome_rounded,
                                  size: 70,
                                  color: Colors.white,
                                ),
                              )
                                  .animate()
                                  .scale(
                                    duration: 1000.ms,
                                    curve: Curves.elasticOut,
                                  )
                                  .fadeIn(),
                              const SizedBox(height: 30),
                              Text(
                                getText('appName', selectedLanguage),
                                style: GoogleFonts.poppins(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: -1,
                                ),
                              )
                                  .animate()
                                  .fadeIn(duration: 600.ms, delay: 200.ms)
                                  .slideY(
                                    begin: -0.3,
                                    duration: 600.ms,
                                    delay: 200.ms,
                                  ),
                              const SizedBox(height: 8),
                              Text(
                                getText('tagline', selectedLanguage),
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white70,
                                  letterSpacing: 0.5,
                                ),
                                textAlign: TextAlign.center,
                              )
                                  .animate()
                                  .fadeIn(duration: 600.ms, delay: 400.ms)
                                  .slideY(
                                    begin: 0.3,
                                    duration: 600.ms,
                                    delay: 400.ms,
                                  ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: 280,
                                child: Text(
                                  getText('description', selectedLanguage),
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white60,
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                                  .animate()
                                  .fadeIn(duration: 600.ms, delay: 600.ms),
                            ],
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                              child: Container(
                                padding: const EdgeInsets.all(24),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 24),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                    width: 1.5,
                                  ),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withOpacity(0.12),
                                      Colors.white.withOpacity(0.06),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 20,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.format_quote_rounded,
                                      color: Colors.white.withOpacity(0.6),
                                      size: 28,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      getText('quote', selectedLanguage),
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        height: 1.6,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                              .animate()
                              .slideY(
                                begin: 0.5,
                                duration: 800.ms,
                                delay: 600.ms,
                              )
                              .fadeIn(),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF06b6d4)
                                          .withOpacity(0.4),
                                      blurRadius: 20,
                                      spreadRadius: 4,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (context, animation,
                                                    secondaryAnimation) =>
                                                const DashboardScreen(),
                                        transitionsBuilder: (context,
                                            animation,
                                            secondaryAnimation,
                                            child) {
                                          const begin = Offset(1.0, 0.0);
                                          const end = Offset.zero;
                                          const curve = Curves.easeInOut;
                                          var tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
                                          return SlideTransition(
                                            position:
                                                animation.drive(tween),
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color(0xFF06b6d4),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 48, vertical: 18),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(32),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        getText('buttonText', selectedLanguage),
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.arrow_forward_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                                  .animate()
                                  .scale(
                                    duration: 700.ms,
                                    delay: 800.ms,
                                    curve: Curves.easeOut,
                                  )
                                  .fadeIn(),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      themeProvider.toggleTheme();
                                    },
                                    child: _buildIndicatorPill(
                                      isDarkMode
                                          ? Icons.dark_mode_rounded
                                          : Icons.light_mode_rounded,
                                      isDarkMode
                                          ? (selectedLanguage == 'es'
                                              ? 'Oscuro'
                                              : 'Dark')
                                          : (selectedLanguage == 'es'
                                              ? 'Claro'
                                              : 'Light'),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  GestureDetector(
                                    onTap: () {
                                      themeProvider.toggleLanguage();
                                    },
                                    child: _buildIndicatorPill(
                                      Icons.language_rounded,
                                      selectedLanguage == 'es'
                                          ? 'Español'
                                          : 'English',
                                    ),
                                  ),
                                ],
                              )
                                  .animate()
                                  .fadeIn(duration: 600.ms, delay: 1000.ms),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildIndicatorPill(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white.withOpacity(0.12),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class ParticlePainter extends CustomPainter {
  final double animationValue;
  final bool isDarkMode;

  ParticlePainter({
    required this.animationValue,
    required this.isDarkMode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..strokeWidth = 2;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    for (int i = 0; i < 3; i++) {
      final radius = 50.0 + (i * 40) + (animationValue * 30);
      final opacity = (1 - animationValue) * 0.15;

      canvas.drawCircle(
        Offset(centerX, centerY),
        radius,
        paint..color = Colors.white.withOpacity(opacity),
      );
    }

    for (int i = 0; i < 8; i++) {
      final angle = (i / 8) * 2 * math.pi;
      final distance = 120 + (animationValue * 50);
      final x = centerX + distance * math.cos(angle);
      final y = centerY + distance * math.sin(angle);

      final particleOpacity =
          (0.2 * (1 - (animationValue * animationValue))).clamp(0.0, 0.2);

      canvas.drawCircle(
        Offset(x, y),
        3,
        paint..color = Colors.white.withOpacity(particleOpacity),
      );
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}