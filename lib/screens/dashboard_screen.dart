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
        final borderColor =
            isDarkMode ? Colors.grey[800] : Colors.grey[100];

        return Scaffold(
          body: _screens[_selectedIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: borderColor!, width: 1),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDarkMode ? 0.2 : 0.08),
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
      'notificaciones': 'Notificaciones',
      'sinNotificaciones': 'No hay notificaciones',
      'marcarLeida': 'Marcar como leída',
      'marcarNoLeida': 'Marcar como no leída',
      'eliminar': 'Eliminar',
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
      'notificaciones': 'Notifications',
      'sinNotificaciones': 'No notifications',
      'marcarLeida': 'Mark as read',
      'marcarNoLeida': 'Mark as unread',
      'eliminar': 'Delete',
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
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        final isDarkMode = themeProvider.isDarkMode;
        final selectedLanguage = themeProvider.selectedLanguage;
        final bgColor = isDarkMode ? const Color(0xFF0f0f0f) : Colors.white;
        final textColor = isDarkMode ? Colors.white : const Color(0xFF0b1e6b);
        final cardBgColor =
            isDarkMode ? const Color(0xFF1a1a1a) : Colors.grey[50];
        final borderColor =
            isDarkMode ? Colors.grey[800] : Colors.grey[100];
        final subtextColor =
            isDarkMode ? Colors.grey[500] : Colors.grey[600];

        return Container(
          color: bgColor,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getText('greeting', selectedLanguage),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: subtextColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            getText('title', selectedLanguage),
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: textColor,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _buildIconButton(
                            Icons.notifications_none,
                            isDarkMode,
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotificationsScreen(
                                    isDarkMode: isDarkMode,
                                    selectedLanguage: selectedLanguage,
                                    textColor: textColor,
                                    cardBgColor: cardBgColor,
                                    borderColor: borderColor,
                                    subtextColor: subtextColor,
                                    getText: getText,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              final dashboardState =
                                  context.findAncestorStateOfType<
                                      _DashboardScreenState>();
                              dashboardState?._onItemTapped(4);
                            },
                            child: _buildProfileAvatar(isDarkMode),
                          ),
                        ],
                      ),
                    ],
                  ).animate().fadeIn(duration: 400.ms),

                  const SizedBox(height: 28),

                  // Metrics Title
                  Text(
                    getText('metricsTitle', selectedLanguage),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: textColor,
                      letterSpacing: -0.3,
                    ),
                  ).animate().fadeIn(duration: 400.ms, delay: 100.ms),

                  const SizedBox(height: 16),

                  // Metrics Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          getText('stress', selectedLanguage),
                          '8.2',
                          getText('stressLevel', selectedLanguage),
                          getText('stressChange', selectedLanguage),
                          Colors.red,
                          isDarkMode,
                          cardBgColor,
                          borderColor,
                          subtextColor,
                          textColor,
                        ),
                      ).animate()
                          .slideX(begin: -0.5, duration: 600.ms, delay: 200.ms),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildMetricCard(
                          getText('motivation', selectedLanguage),
                          '75%',
                          getText('motivationLevel', selectedLanguage),
                          'Muy Activo',
                          Colors.green,
                          isDarkMode,
                          cardBgColor,
                          borderColor,
                          subtextColor,
                          textColor,
                        ),
                      ).animate()
                          .slideX(begin: 0.5, duration: 600.ms, delay: 200.ms),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Performance Card
                  _buildPerformanceCard(
                    getText('performance', selectedLanguage),
                    '7/10',
                    getText('performanceStatus', selectedLanguage),
                    getText('performanceConsistent', selectedLanguage),
                    isDarkMode,
                  ).animate()
                      .scale(duration: 600.ms, delay: 300.ms),

                  const SizedBox(height: 28),

                  // Daily Quote
                  _buildQuoteCard(
                    getText('dailyQuote', selectedLanguage),
                    getText('searchInspiration', selectedLanguage),
                    isDarkMode,
                    cardBgColor,
                    borderColor,
                    subtextColor,
                    textColor,
                  ).animate()
                      .slideY(begin: 0.4, duration: 600.ms, delay: 300.ms),

                  const SizedBox(height: 28),

                  // Reminders Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getText('upcomingReminders', selectedLanguage),
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: textColor,
                          letterSpacing: -0.3,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: cardBgColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                            builder: (context) {
                              return Container(
                                color: bgColor,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        child: Container(
                                          width: 40,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 8, 20, 16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              getText('upcomingReminders',
                                                  selectedLanguage),
                                              style: GoogleFonts.poppins(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w800,
                                                color: textColor,
                                                letterSpacing: -0.5,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Total: ${reminders.length} recordatorios',
                                              style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                color: subtextColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: reminders.length,
                                          itemBuilder: (context, index) {
                                            final reminder =
                                                reminders[index];
                                            return _buildReminderItem(
                                              reminder,
                                              index,
                                              isDarkMode,
                                              cardBgColor,
                                              borderColor,
                                              subtextColor,
                                              textColor,
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color:
                                const Color(0xFF8b5cf6).withOpacity(0.1),
                            border: Border.all(
                              color: const Color(0xFF8b5cf6)
                                  .withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            getText('viewAll', selectedLanguage),
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF8b5cf6),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).animate()
                      .fadeIn(duration: 400.ms, delay: 400.ms),

                  const SizedBox(height: 12),

                  // Reminders List (Solo los primeros 3)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reminders.length > 3 ? 3 : reminders.length,
                    itemBuilder: (context, index) {
                      final reminder = reminders[index];
                      return _buildReminderItem(
                        reminder,
                        index,
                        isDarkMode,
                        cardBgColor,
                        borderColor,
                        subtextColor,
                        textColor,
                      );
                    },
                  ),

                  // Ver más reminders
                  if (reminders.length > 3)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Center(
                        child: Text(
                          '+ ${reminders.length - 3} recordatorios más',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF8b5cf6),
                          ),
                        ),
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

  Widget _buildIconButton(IconData icon, bool isDarkMode, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDarkMode ? const Color(0xFF1a1a1a) : Colors.grey[100],
          border: Border.all(
            color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
            width: 1.5,
          ),
        ),
        child: Icon(
          icon,
          color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
          size: 20,
        ),
      ),
    );
  }

  Widget _buildProfileAvatar(bool isDarkMode) {
    return ClipOval(
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
            width: 2,
          ),
        ),
        child: Image.network(
          'https://api.dicebear.com/7.x/avataaars/svg?seed=Felix',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF8b5cf6), Color(0xFF06b6d4)],
                ),
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 22,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    String status,
    String change,
    Color accentColor,
    bool isDarkMode,
    Color? cardBgColor,
    Color? borderColor,
    Color? subtextColor,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor!, width: 1.5),
        color: cardBgColor,
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: subtextColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: accentColor.withOpacity(0.15),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: accentColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: accentColor,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            change,
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: subtextColor,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceCard(
    String title,
    String value,
    String status,
    String subtitle,
    bool isDarkMode,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF06d4d4).withOpacity(0.9),
            const Color(0xFF06b6d4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF06b6d4).withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white.withOpacity(0.25),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
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
                value,
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteCard(
    String title,
    String buttonText,
    bool isDarkMode,
    Color? cardBgColor,
    Color? borderColor,
    Color? subtextColor,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor!, width: 1.5),
        color: cardBgColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.1 : 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: textColor,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            '"El futuro pertenece a quienes creen en la belleza de sus sueños."',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: isDarkMode ? Colors.grey[300] : Colors.grey[800],
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '— Eleanor Roosevelt',
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: subtextColor,
              ),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8b5cf6),
                padding: const EdgeInsets.symmetric(vertical: 11),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                shadowColor: const Color(0xFF8b5cf6).withOpacity(0.3),
              ),
              child: Text(
                buttonText,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReminderItem(
    Map<String, dynamic> reminder,
    int index,
    bool isDarkMode,
    Color? cardBgColor,
    Color? borderColor,
    Color? subtextColor,
    Color textColor,
  ) {
    final isPriority = reminder['priority'] == 'high';
    final priorityColor = isPriority ? Colors.red[500] : Colors.grey[400];

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: cardBgColor,
        border: Border.all(
          color: borderColor!,
          width: reminder['completed'] ? 1 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.08 : 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
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
              side: BorderSide(
                color: borderColor,
                width: 1.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reminder['title'],
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: reminder['completed'] ? subtextColor : textColor,
                    decoration: reminder['completed']
                        ? TextDecoration.lineThrough
                        : null,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  reminder['time'],
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: subtextColor,
                  ),
                ),
              ],
            ),
          ),
          if (isPriority)
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: priorityColor,
              ),
            ),
        ],
      ),
    )
        .animate()
        .slideX(
          begin: -0.3,
          duration: 600.ms,
          delay: Duration(milliseconds: 400 + (index * 80)),
        )
        .fadeIn();
  }
}

class NotificationsScreen extends StatefulWidget {
  final bool isDarkMode;
  final String selectedLanguage;
  final Color textColor;
  final Color? cardBgColor;
  final Color? borderColor;
  final Color? subtextColor;
  final Function getText;

  const NotificationsScreen({
    super.key,
    required this.isDarkMode,
    required this.selectedLanguage,
    required this.textColor,
    required this.cardBgColor,
    required this.borderColor,
    required this.subtextColor,
    required this.getText,
  });

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<Map<String, dynamic>> notifications;

  @override
  void initState() {
    super.initState();
    notifications = [
      {
        'title': 'Nueva Tarea Asignada',
        'description': 'Se te ha asignado una nueva tarea de matemáticas',
        'time': 'Hace 2 horas',
        'read': false,
        'icon': Icons.assignment,
        'color': Colors.blue,
      },
      {
        'title': 'Recordatorio de Sesión',
        'description': 'Tu sesión con el mentor comienza en 30 minutos',
        'time': 'Hace 4 horas',
        'read': false,
        'icon': Icons.people,
        'color': Colors.purple,
      },
      {
        'title': 'Logro Desbloqueado',
        'description': 'Felicidades, completaste 10 tareas esta semana',
        'time': 'Hace 1 día',
        'read': true,
        'icon': Icons.star,
        'color': Colors.amber,
      },
      {
        'title': 'Mensaje de Mentor',
        'description': 'Tu mentor dejó un comentario en tu ensayo',
        'time': 'Hace 2 días',
        'read': true,
        'icon': Icons.mail,
        'color': Colors.green,
      },
      {
        'title': 'Actualización del Sistema',
        'description': 'Nueva versión disponible con mejoras',
        'time': 'Hace 3 días',
        'read': true,
        'icon': Icons.update,
        'color': Colors.orange,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final bgColor =
        widget.isDarkMode ? const Color(0xFF0f0f0f) : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: widget.textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.getText('notificaciones', widget.selectedLanguage),
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: widget.textColor,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: false,
      ),
      body: notifications.isEmpty
          ? Center(
              child: Text(
                widget.getText('sinNotificaciones',
                    widget.selectedLanguage),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: widget.subtextColor,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return GestureDetector(
                  onLongPress: () => _showNotificationOptions(
                      context, index, notification),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: notification['read']
                          ? widget.cardBgColor
                          : (widget.isDarkMode
                              ? const Color(0xFF1a2a3a)
                              : Colors.blue[50]),
                      border: Border.all(
                        color: notification['read']
                            ? widget.borderColor!
                            : Colors.blue[300]!,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(
                              widget.isDarkMode ? 0.1 : 0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (notification['color'] as Color)
                                .withOpacity(0.15),
                          ),
                          child: Icon(
                            notification['icon'],
                            color: notification['color'],
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      notification['title'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: widget.textColor,
                                      ),
                                    ),
                                  ),
                                  if (!notification['read'])
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF8b5cf6),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                notification['description'],
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: widget.subtextColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                notification['time'],
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: widget.subtextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .slideX(
                        begin: 0.3,
                        duration: 500.ms,
                        delay: Duration(milliseconds: 100 * index),
                      )
                      .fadeIn(),
                );
              },
            ),
    );
  }

  void _showNotificationOptions(
      BuildContext context, int index, Map<String, dynamic> notification) {
    showModalBottomSheet(
      context: context,
      backgroundColor: widget.isDarkMode
          ? const Color(0xFF1a1a1a)
          : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              ListTile(
                leading: Icon(
                  notification['read']
                      ? Icons.mail_outline
                      : Icons.done_all,
                  color: const Color(0xFF8b5cf6),
                  size: 24,
                ),
                title: Text(
                  notification['read']
                      ? widget.getText(
                          'marcarNoLeida', widget.selectedLanguage)
                      : widget.getText(
                          'marcarLeida', widget.selectedLanguage),
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: widget.textColor,
                  ),
                ),
                onTap: () {
                  setState(() {
                    notifications[index]['read'] = !notification['read'];
                  });
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: Icon(
                  Icons.delete_outline,
                  color: Colors.red[500],
                  size: 24,
                ),
                title: Text(
                  widget.getText('eliminar', widget.selectedLanguage),
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.red[500],
                  ),
                ),
                onTap: () {
                  setState(() {
                    notifications.removeAt(index);
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}