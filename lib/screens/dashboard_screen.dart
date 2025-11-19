import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:mentoria/providers/theme_provider.dart';
import 'package:mentoria/providers/notifications_provider.dart';

import 'package:mentoria/screens/profile_screen.dart';
import 'chat_screen.dart';
import 'recommendations_screen.dart';
import 'mentor_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = [
    const DashboardContent(),
    const RecommendationsScreen(),
    const MentorScreen(), 
    const ChatScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        final isDarkMode = themeProvider.isDarkMode;
        final borderColor = isDarkMode ? Colors.grey[800] : Colors.grey[100];

        return Scaffold(
          body: _screens[_selectedIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: borderColor!, width: 1),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDarkMode ? 0.2 : 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, -8),
                ),
              ],
            ),
            child: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: 'Inicio',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.lightbulb_outline),
                  label: 'Recomendaciones',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people_outline),
                  label: 'Mentores',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_outline),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: 'Perfil',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              selectedItemColor: const Color(0xFF8b5cf6),
              unselectedItemColor:
                  isDarkMode ? Colors.grey[600] : Colors.grey[400],
              backgroundColor:
                  isDarkMode ? const Color(0xFF0f0f0f) : Colors.white,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedLabelStyle: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ).animate().slideY(begin: 1, duration: 600.ms),
        );
      },
    );
  }
}

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  late List<Map<String, dynamic>> reminders;

  final Map<String, Map<String, String>> texts = {
    'es': {
      'title': 'MentoriA',
      'greeting': '¡Hola de nuevo!',
      'metricsTitle': 'Tus Métricas de Bienestar',
      'stress': 'Estrés',
      'stressLevel': 'Alto',
      'stressChange': '↑ +1.4 desde la semana pasada',
      'motivation': 'Motivación',
      'motivationLevel': 'Estable',
      'performance': 'Desempeño',
      'performanceStatus': 'En Progreso',
      'performanceConsistent': 'Consistente',
      'dailyQuote': '💡 Motivación Diaria',
      'upcomingReminders': 'Mis Recordatorios',
      'viewAll': 'Ver Todo',
      'searchInspiration': '🔍 Más inspiración',
    },
    'en': {
      'title': 'MentoriA',
      'greeting': 'Welcome back!',
      'metricsTitle': 'Your Wellness Metrics',
      'stress': 'Stress',
      'stressLevel': 'High',
      'stressChange': '↑ +1.4 from last week',
      'motivation': 'Motivation',
      'motivationLevel': 'Stable',
      'performance': 'Performance',
      'performanceStatus': 'In Progress',
      'performanceConsistent': 'Consistent',
      'dailyQuote': '💡 Daily Motivation',
      'upcomingReminders': 'My Reminders',
      'viewAll': 'View All',
      'searchInspiration': '🔍 More inspiration',
    },
  };

  String getText(String key, String language) {
    return texts[language]?[key] ?? '';
  }

  @override
  void initState() {
    super.initState();
    reminders = [
      {
        'title': 'Completar Tarea de Cálculo',
        'time': 'Hoy, 3:00 PM',
        'completed': false,
        'priority': 'high',
      },
      {
        'title': 'Sesión de Mentoría con Dr. Lee',
        'time': 'Mañana, 10:00 AM',
        'completed': false,
        'priority': 'high',
      },
      {
        'title': 'Enviar Borrador de Ensayo',
        'time': 'Viernes, 5:00 PM',
        'completed': false,
        'priority': 'medium',
      },
      {
        'title': 'Sesión de Ejercicio en el Gimnasio',
        'time': 'Viernes, 7:00 PM',
        'completed': true,
        'priority': 'low',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, NotificationsProvider>(
      builder: (context, themeProvider, notificationsProvider, _) {
        final isDarkMode = themeProvider.isDarkMode;
        final language = themeProvider.selectedLanguage;

        final bgColor =
            isDarkMode ? const Color(0xFF0f0f0f) : Colors.white;
        final textColor =
            isDarkMode ? Colors.white : const Color(0xFF0b1e6b);

        return Container(
          padding: const EdgeInsets.all(20),
          color: bgColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getText('greeting', language),
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 10),

              // Aquí puedes continuar contenido adicional
            ],
          ),
        );
      },
    );
  }
}
