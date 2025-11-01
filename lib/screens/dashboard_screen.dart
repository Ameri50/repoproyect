import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mentoria/providers/theme_provider.dart';
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
    RecommendationsScreen(),
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

        return Scaffold(
          body: _screens[_selectedIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Inicio',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today),
                    label: 'Plan',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.people),
                    label: 'Mentores',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.chat),
                    label: 'Chat',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Perfil',
                  ),
                ],
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                selectedItemColor: const Color(0xFF8b5cf6),
                unselectedItemColor: Colors.grey,
                backgroundColor: isDarkMode ? const Color(0xFF1a1a1a) : Colors.white,
                type: BottomNavigationBarType.fixed,
                elevation: 0,
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
      'metricsTitle': 'Tus Métricas de Bienestar',
      'stress': 'Nivel de Estrés',
      'stressLevel': 'Alto',
      'stressChange': '↑ aumentó 1.4 desde la semana pasada',
      'motivation': 'Motivación',
      'motivationLevel': 'Estable',
      'performance': 'Puntuación de Desempeño',
      'performanceStatus': 'En Progreso',
      'performanceConsistent': 'Consistente',
      'dailyQuote': 'Motivación Diaria',
      'upcomingReminders': 'Recordatorios Próximos',
      'viewAll': 'Ver Todo',
      'searchInspiration': '🔍 Buscar más inspiración',
    },
    'en': {
      'title': 'MentoriA',
      'metricsTitle': 'Your Wellness Metrics',
      'stress': 'Stress Level',
      'stressLevel': 'High',
      'stressChange': '↑ increased 1.4 from last week',
      'motivation': 'Motivation',
      'motivationLevel': 'Stable',
      'performance': 'Performance Score',
      'performanceStatus': 'In Progress',
      'performanceConsistent': 'Consistent',
      'dailyQuote': 'Daily Motivation',
      'upcomingReminders': 'Upcoming Reminders',
      'viewAll': 'View All',
      'searchInspiration': '🔍 Search for more inspiration',
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
        'completed': false
      },
      {
        'title': 'Sesión de Mentoría con Dr. Lee',
        'time': 'Mañana, 10:00 AM',
        'completed': false
      },
      {
        'title': 'Enviar Borrador de Ensayo',
        'time': 'Viernes, 5:00 PM',
        'completed': false
      },
      {
        'title': 'Sesión de Ejercicio en el Gimnasio',
        'time': 'Viernes, 7:00 PM',
        'completed': true
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        final isDarkMode = themeProvider.isDarkMode;
        final selectedLanguage = themeProvider.selectedLanguage;
        final bgColor = isDarkMode ? const Color(0xFF1a1a1a) : Colors.white;
        final textColor = isDarkMode ? Colors.white : const Color(0xFF0b1e6b);
        final cardBgColor = isDarkMode ? const Color(0xFF2a2a2a) : Colors.white;
        final borderColor = isDarkMode ? Colors.grey[700] : Colors.grey[200];
        final subtextColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];

        return Container(
          color: bgColor,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        getText('title', selectedLanguage),
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.notifications_none),
                            color: isDarkMode ? Colors.grey[400] : Colors.grey,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navega al perfil (índice 4)
                              final dashboardState = context.findAncestorStateOfType<_DashboardScreenState>();
                              dashboardState?._onItemTapped(4);
                            },
                            child: ClipOval(
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
                          ),
                        ],
                      ),
                    ],
                  ).animate().fadeIn(duration: 600.ms),
                  const SizedBox(height: 30),
                  Text(
                    getText('metricsTitle', selectedLanguage),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 100.ms),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: borderColor!),
                            color: cardBgColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    getText('stress', selectedLanguage),
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: subtextColor,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.red[100],
                                    ),
                                    child: Text(
                                      getText('stressLevel', selectedLanguage),
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red[700],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: Text(
                                  '8.2',
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.red[600],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Center(
                                child: Text(
                                  getText('stressChange', selectedLanguage),
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: subtextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).animate()
                          .slideX(begin: -0.5, duration: 600.ms, delay: 200.ms),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: borderColor),
                            color: cardBgColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    getText('motivation', selectedLanguage),
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: subtextColor,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.green[100],
                                    ),
                                    child: Text(
                                      getText('motivationLevel', selectedLanguage),
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green[700],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: Text(
                                  '75%',
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.green[600],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).animate()
                          .slideX(begin: 0.5, duration: 600.ms, delay: 200.ms),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF06d4d4), Color(0xFF06b6d4)],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getText('performance', selectedLanguage),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white.withValues(alpha: 0.3),
                              ),
                              child: Text(
                                getText('performanceStatus', selectedLanguage),
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '7/10',
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              getText('performanceConsistent', selectedLanguage),
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).animate().scale(duration: 600.ms, delay: 300.ms),
                  const SizedBox(height: 30),
                  Text(
                    getText('dailyQuote', selectedLanguage),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: borderColor),
                      color: cardBgColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '"El futuro pertenece a quienes creen en la belleza de sus sueños."',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: isDarkMode ? Colors.grey[300] : Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '- Eleanor Roosevelt',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: subtextColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: isDarkMode ? Colors.grey[600]! : Colors.grey,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              getText('searchInspiration', selectedLanguage),
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().slideY(begin: 0.3, duration: 600.ms, delay: 400.ms),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getText('upcomingReminders', selectedLanguage),
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      Text(
                        getText('viewAll', selectedLanguage),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF8b5cf6),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reminders.length,
                    itemBuilder: (context, index) {
                      final reminder = reminders[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: cardBgColor,
                          border: Border.all(color: borderColor),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 24,
                              child: Checkbox(
                                value: reminder['completed'],
                                onChanged: (value) {
                                  setState(() {
                                    reminder['completed'] = value ?? false;
                                  });
                                },
                                activeColor: const Color(0xFF8b5cf6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                reminder['title'],
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: reminder['completed']
                                      ? subtextColor
                                      : textColor,
                                  decoration: reminder['completed']
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              reminder['time'],
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: subtextColor,
                              ),
                            ),
                          ],
                        ),
                      ).animate().slideX(
                            begin: -0.3,
                            duration: 600.ms,
                            delay: Duration(milliseconds: 500 + (index * 100)),
                          );
                    },
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
}