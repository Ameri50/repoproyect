import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:mentoria/providers/theme_provider.dart';
import 'package:mentoria/providers/notifications_provider.dart';
import 'package:mentoria/screens/profile_screen.dart';
import 'package:mentoria/screens/chat_screen.dart';
import 'package:mentoria/screens/recommendations_screen.dart';
import 'package:mentoria/screens/mentor_screen.dart';

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

        return Scaffold(
          body: _screens[_selectedIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: isDarkMode
                      ? Colors.grey[900]!.withValues(alpha: 0.5)
                      : Colors.grey[200]!.withValues(alpha: 0.5),
                  width: 0.5,
                ),
              ),
              color: isDarkMode
                  ? const Color(0xFF0f0f0f).withValues(alpha: 0.8)
                  : Colors.white.withValues(alpha: 0.8),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                  unselectedItemColor: isDarkMode
                      ? Colors.grey[600]
                      : Colors.grey[400],
                  backgroundColor: Colors.transparent,
                  type: BottomNavigationBarType.fixed,
                  elevation: 0,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  selectedLabelStyle: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: GoogleFonts.poppins(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
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

  static final Map<String, Map<String, String>> texts = {
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

        final bgColor = isDarkMode ? const Color(0xFF0f0f0f) : Colors.white;
        final textColor = isDarkMode ? Colors.white : Colors.black;
        final secondaryText = isDarkMode ? Colors.grey[400] : Colors.grey[600];
        final cardBg = isDarkMode
            ? Colors.grey[900]!.withValues(alpha: 0.5)
            : Colors.grey[50]!.withValues(alpha: 0.7);

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            color: bgColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header con SafeArea
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getText('greeting', language),
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                          letterSpacing: -0.5,
                        ),
                      ).animate().fadeIn(duration: 400.ms),
                      const SizedBox(height: 4),
                      Text(
                        'Miércoles, 20 de Noviembre',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: secondaryText,
                        ),
                      ).animate().fadeIn(duration: 500.ms),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // Métricas de Bienestar - Estilo Apple
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getText('metricsTitle', language),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildAppleMetricCard(
                            language,
                            getText('stress', language),
                            getText('stressLevel', language),
                            getText('stressChange', language),
                            Colors.red,
                            cardBg,
                            textColor,
                            secondaryText,
                          ),
                          const SizedBox(width: 12),
                          _buildAppleMetricCard(
                            language,
                            getText('motivation', language),
                            getText('motivationLevel', language),
                            '',
                            Colors.green,
                            cardBg,
                            textColor,
                            secondaryText,
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1),
                const SizedBox(height: 24),

                // Desempeño - Card grande Apple
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDarkMode
                            ? Colors.grey[800]!.withValues(alpha: 0.3)
                            : Colors.grey[200]!.withValues(alpha: 0.5),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getText('performance', language),
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: textColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  getText('performanceConsistent', language),
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: secondaryText,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                getText('performanceStatus', language),
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: 0.72,
                            minHeight: 6,
                            backgroundColor: isDarkMode
                                ? Colors.grey[800]
                                : Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              const Color(0xFF8b5cf6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.1),
                const SizedBox(height: 24),

                // Cita Motivacional - Glassmorphism
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF8b5cf6).withValues(alpha: 0.9),
                          const Color(0xFF6366f1).withValues(alpha: 0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF8b5cf6).withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getText('dailyQuote', language),
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withValues(alpha: 0.9),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          '"El éxito no es final, el fracaso no es fatal: lo que cuenta es el coraje para continuar."',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            height: 1.6,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1),
                const SizedBox(height: 28),

                // Recordatorios
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getText('upcomingReminders', language),
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              _showAllReminders(
                                context,
                                cardBg,
                                textColor,
                                secondaryText,
                                isDarkMode,
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Text(
                              getText('viewAll', language),
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF8b5cf6),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (reminders.isNotEmpty)
                        ...reminders
                            .take(3)
                            .toList()
                            .asMap()
                            .entries
                            .map((e) => _buildAppleReminderTile(
                              e.value,
                              cardBg,
                              textColor,
                              secondaryText,
                              isDarkMode,
                              delay: (e.key + 1) * 100,
                            )),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppleMetricCard(
    String language,
    String title,
    String level,
    String change,
    Color color,
    Color cardBg,
    Color textColor,
    Color? secondaryText,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: color.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                title.contains('Estrés') || title.contains('Stress')
                    ? Icons.trending_up_rounded
                    : Icons.favorite_rounded,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: secondaryText,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              level,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            if (change.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                change,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: secondaryText,
                  height: 1.4,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showAllReminders(
    BuildContext context,
    Color cardBg,
    Color textColor,
    Color? secondaryText,
    bool isDarkMode,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF0f0f0f) : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
            border: Border(
              top: BorderSide(
                color: isDarkMode
                    ? Colors.grey[800]!.withValues(alpha: 0.3)
                    : Colors.grey[200]!.withValues(alpha: 0.5),
              ),
            ),
          ),
          child: Column(
            children: [
              // Handle
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Todos los Recordatorios',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          color: textColor,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Lista de recordatorios
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: reminders.length,
                  itemBuilder: (context, index) {
                    return _buildAppleReminderTile(
                      reminders[index],
                      cardBg,
                      textColor,
                      secondaryText,
                      isDarkMode,
                      delay: index * 50,
                    );
                  },
                ),
              ),
              // Botón agregar recordatorio
              Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _openAddReminderForm(cardBg, textColor, secondaryText, isDarkMode);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8b5cf6),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add_rounded, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          'Agregar Recordatorio',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openAddReminderForm(
    Color cardBg,
    Color textColor,
    Color? secondaryText,
    bool isDarkMode,
  ) {
    final titleController = TextEditingController();
    final timeController = TextEditingController();
    String selectedPriority = 'medium';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF0f0f0f) : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                    border: Border(
                      top: BorderSide(
                        color: isDarkMode
                            ? Colors.grey[800]!.withValues(alpha: 0.3)
                            : Colors.grey[200]!.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                      left: 20,
                      right: 20,
                      top: 20,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Handle
                        Center(
                          child: Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.grey[700]
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Título
                        Text(
                          'Nuevo Recordatorio',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Título del recordatorio
                        Text(
                          'Título',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: titleController,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: textColor,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Ej: Estudiar para el examen',
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 14,
                              color: secondaryText,
                            ),
                            filled: true,
                            fillColor: cardBg,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: isDarkMode
                                    ? Colors.grey[800]!.withValues(alpha: 0.3)
                                    : Colors.grey[200]!.withValues(alpha: 0.5),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: isDarkMode
                                    ? Colors.grey[800]!.withValues(alpha: 0.3)
                                    : Colors.grey[200]!.withValues(alpha: 0.5),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFF8b5cf6),
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(14),
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Hora/Fecha
                        Text(
                          'Fecha y Hora',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now()
                                  .add(const Duration(days: 365)),
                            );
                            if (date != null) {
                              if (context.mounted) {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (time != null) {
                                  final formattedDate =
                                      '${date.day}/${date.month}/${date.year}, ${time.hour}:${time.minute.toString().padLeft(2, '0')} ${time.period.name.toUpperCase()}';
                                  setState(() {
                                    timeController.text = formattedDate;
                                  });
                                }
                              }
                            }
                          },
                          child: TextField(
                            controller: timeController,
                            enabled: false,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: textColor,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Selecciona fecha y hora',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                color: secondaryText,
                              ),
                              filled: true,
                              fillColor: cardBg,
                              prefixIcon: Icon(
                                Icons.calendar_today_rounded,
                                color: const Color(0xFF8b5cf6),
                                size: 18,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: isDarkMode
                                      ? Colors.grey[800]!.withValues(alpha: 0.3)
                                      : Colors.grey[200]!
                                          .withValues(alpha: 0.5),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: isDarkMode
                                      ? Colors.grey[800]!.withValues(alpha: 0.3)
                                      : Colors.grey[200]!
                                          .withValues(alpha: 0.5),
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(14),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Prioridad
                        Text(
                          'Prioridad',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _buildPriorityButton(
                              'Baja',
                              'low',
                              Colors.green,
                              selectedPriority,
                              cardBg,
                              textColor,
                              (value) =>
                                  setState(() => selectedPriority = value),
                            ),
                            const SizedBox(width: 10),
                            _buildPriorityButton(
                              'Media',
                              'medium',
                              Colors.orange,
                              selectedPriority,
                              cardBg,
                              textColor,
                              (value) =>
                                  setState(() => selectedPriority = value),
                            ),
                            const SizedBox(width: 10),
                            _buildPriorityButton(
                              'Alta',
                              'high',
                              Colors.red,
                              selectedPriority,
                              cardBg,
                              textColor,
                              (value) =>
                                  setState(() => selectedPriority = value),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),

                        // Botones
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  decoration: BoxDecoration(
                                    color: cardBg,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isDarkMode
                                          ? Colors.grey[800]!
                                              .withValues(alpha: 0.3)
                                          : Colors.grey[200]!
                                              .withValues(alpha: 0.5),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Cancelar',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: textColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  if (titleController.text.isNotEmpty) {
                                    setState(() {
                                      reminders.add({
                                        'title': titleController.text,
                                        'time': timeController.text.isEmpty
                                            ? 'Próximamente'
                                            : timeController.text,
                                        'completed': false,
                                        'priority': selectedPriority,
                                      });
                                    });
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Recordatorio agregado',
                                          style: GoogleFonts.poppins(),
                                        ),
                                        backgroundColor:
                                            const Color(0xFF8b5cf6),
                                        duration:
                                            const Duration(seconds: 2),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Por favor completa el título',
                                          style: GoogleFonts.poppins(),
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF8b5cf6),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Guardar',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPriorityButton(
    String label,
    String value,
    Color color,
    String selectedPriority,
    Color cardBg,
    Color textColor,
    Function(String) onSelect,
  ) {
    final isSelected = selectedPriority == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => onSelect(value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? color.withValues(alpha: 0.2) : cardBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? color : Colors.grey[300]!,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? color : textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppleReminderTile(
    Map<String, dynamic> reminder,
    Color cardBg,
    Color textColor,
    Color? secondaryText,
    bool isDarkMode, {
    int delay = 0,
  }) {
    final Color priorityColor = reminder['priority'] == 'high'
        ? Colors.red
        : reminder['priority'] == 'medium'
            ? Colors.orange
            : Colors.green;

    final IconData priorityIcon = reminder['priority'] == 'high'
        ? Icons.priority_high_rounded
        : reminder['priority'] == 'medium'
            ? Icons.info_rounded
            : Icons.check_circle_rounded;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode
              ? Colors.grey[800]!.withValues(alpha: 0.3)
              : Colors.grey[200]!.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: priorityColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              priorityIcon,
              color: priorityColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reminder['title'],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  reminder['time'],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: secondaryText,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              setState(() {
                reminder['completed'] = !reminder['completed'];
              });
            },
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: reminder['completed']
                    ? const Color(0xFF8b5cf6)
                    : Colors.transparent,
                border: Border.all(
                  color: reminder['completed']
                      ? const Color(0xFF8b5cf6)
                      : isDarkMode
                          ? Colors.grey[700]!
                          : Colors.grey[300]!,
                  width: 2,
                ),
              ),
              child: reminder['completed']
                  ? const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 14,
                    )
                  : null,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms, delay: Duration(milliseconds: delay)).slideX(begin: 0.1);
  }
}