import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mentoria/providers/theme_provider.dart';
import 'package:mentoria/screens/profile_screen.dart';

class MentorScreen extends StatefulWidget {
  const MentorScreen({super.key});

  @override
  State<MentorScreen> createState() => _MentorScreenState();
}

class _MentorScreenState extends State<MentorScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'Todos';
  late AnimationController _animationController;

  final Map<String, Map<String, String>> texts = {
    'es': {
      'title': 'Mentor Connect',
      'subtitle': 'Encuentra tu mentor ideal',
      'searchPlaceholder': 'Buscar mentores...',
      'filterAll': 'Todos',
      'filterAcademic': 'Académico',
      'filterEmotional': 'Emocional',
      'buttonConnect': 'Conectar',
      'notificaciones': 'Notificaciones',
      'sinNotificaciones': 'No hay notificaciones',
      'marcarLeida': 'Marcar como leída',
      'marcarNoLeida': 'Marcar como no leída',
      'eliminar': 'Eliminar',
    },
    'en': {
      'title': 'Mentor Connect',
      'subtitle': 'Find your ideal mentor',
      'searchPlaceholder': 'Search mentors...',
      'filterAll': 'All',
      'filterAcademic': 'Academic',
      'filterEmotional': 'Emotional',
      'buttonConnect': 'Connect',
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

  late List<Map<String, dynamic>> notifications;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
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
    ];
  }

  final List<Map<String, dynamic>> mentors = [
    {
      'name': 'Dr. Aruya Sharma',
      'specialty': 'Organizador Experto',
      'specialtyEn': 'Expert Organizer',
      'rating': 4.8,
      'expertise': ['Gestión Académica', 'Manejo del Estrés'],
      'expertiseEn': ['Academic Management', 'Stress Management'],
      'description':
          'Experiencia en ayudar a estudiantes con focus en gestión académica y manejo del estrés.',
      'descriptionEn':
          'Experience helping students focus on academic management and stress handling.',
      'image': 'https://api.dicebear.com/7.x/avataaars/svg?seed=Aruya',
    },
    {
      'name': 'Mark Johnson',
      'specialty': 'Entrenador de Escritura',
      'specialtyEn': 'Academic Writing Coach',
      'rating': 4.9,
      'expertise': ['Escritura Académica', 'Orientación de Carreras'],
      'expertiseEn': ['Academic Writing', 'Career Guidance'],
      'description':
          'Jefe educador enfocado en desarrollar habilidades de escritura y orientación de carrera.',
      'descriptionEn':
          'Chief educator focused on academic writing skills and career guidance.',
      'image': 'https://api.dicebear.com/7.x/avataaars/svg?seed=Mark',
    },
    {
      'name': 'Sarah Lee',
      'specialty': 'Especialista en Productividad',
      'specialtyEn': 'Time Management Specialist',
      'rating': 4.7,
      'expertise': ['Productividad', 'Data Skills', 'Soft Skills'],
      'expertiseEn': ['Productivity', 'Data Skills', 'Soft Skills'],
      'description':
          'Especialista en productividad. Ayuda a estudiantes con técnicas de estudio eficientes.',
      'descriptionEn': 'Specialist in productivity and time management.',
      'image': 'https://api.dicebear.com/7.x/avataaars/svg?seed=Sarah',
    },
    {
      'name': 'David Chen',
      'specialty': 'Asesor de Carrera',
      'specialtyEn': 'Career Development Advisor',
      'rating': 4.6,
      'expertise': ['Desarrollo de Carrera', 'Liderazgo'],
      'expertiseEn': ['Career Development', 'Leadership Skills'],
      'description':
          'Especializado en desarrollo de carrera. Ayuda a navegar opciones profesionales.',
      'descriptionEn': 'Specialized in career development and leadership.',
      'image': 'https://api.dicebear.com/7.x/avataaars/svg?seed=David',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        final isDarkMode = themeProvider.isDarkMode;
        final selectedLanguage = themeProvider.selectedLanguage;
        final bgColor = isDarkMode ? const Color(0xFF0f0f0f) : Colors.white;
        final textColor = isDarkMode ? Colors.white : const Color(0xFF0b1e6b);
        final cardBgColor = isDarkMode ? const Color(0xFF1a1a1a) : Colors.white;
        final borderColor =
            isDarkMode ? Colors.grey[800] : Colors.grey[100];
        final subtextColor =
            isDarkMode ? Colors.grey[500] : Colors.grey[600];

        return Container(
          color: bgColor,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Premium
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDarkMode
                            ? [const Color(0xFF1a1a1a), const Color(0xFF2a2a2a)]
                            : [const Color(0xFF8b5cf6).withOpacity(0.1),
                                Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getText('title', selectedLanguage),
                                style: GoogleFonts.poppins(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: textColor,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                height: 3,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF8b5cf6),
                                      Color(0xFF06b6d4)
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
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
                              _buildIconButton(
                                Icons.notifications_none,
                                isDarkMode,
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NotificationsScreen(
                                        isDarkMode: isDarkMode,
                                        selectedLanguage: selectedLanguage,
                                        textColor: textColor,
                                        cardBgColor: cardBgColor,
                                        borderColor: borderColor,
                                        subtextColor: subtextColor,
                                        getText: getText,
                                        notifications: notifications,
                                        onNotificationsChanged:
                                            (newNotifications) {
                                          setState(() {
                                            notifications = newNotifications;
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileScreen(),
                                    ),
                                  );
                                },
                                child: _buildProfileAvatar(isDarkMode),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(duration: 400.ms),

                  // Search Bar Mejorada
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                    child: TextField(
                      controller: _searchController,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: textColor,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: getText('searchPlaceholder', selectedLanguage),
                        hintStyle: GoogleFonts.poppins(
                          color: subtextColor,
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: subtextColor,
                          size: 22,
                        ),
                        suffixIcon: Icon(
                          Icons.tune,
                          color: subtextColor,
                          size: 22,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: borderColor!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: borderColor,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Color(0xFF8b5cf6),
                            width: 2.5,
                          ),
                        ),
                        filled: true,
                        fillColor: isDarkMode
                            ? const Color(0xFF1a1a1a)
                            : Colors.grey[50],
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ).animate().slideY(begin: -0.3, duration: 500.ms),

                  // Filter Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterButton(
                            getText('filterAll', selectedLanguage),
                            'Todos',
                            isDarkMode,
                            selectedLanguage,
                          ),
                          const SizedBox(width: 10),
                          _buildFilterButton(
                            getText('filterAcademic', selectedLanguage),
                            'Academico',
                            isDarkMode,
                            selectedLanguage,
                          ),
                          const SizedBox(width: 10),
                          _buildFilterButton(
                            getText('filterEmotional', selectedLanguage),
                            'Emocional',
                            isDarkMode,
                            selectedLanguage,
                          ),
                        ],
                      ),
                    ),
                  ).animate()
                      .slideX(begin: -0.5, duration: 500.ms, delay: 100.ms),

                  // Mentors List
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: mentors.length,
                      itemBuilder: (context, index) {
                        final mentor = mentors[index];
                        return _buildMentorCard(
                          mentor,
                          index,
                          isDarkMode,
                          selectedLanguage,
                          textColor,
                          cardBgColor,
                          borderColor,
                          subtextColor,
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

  Widget _buildFilterButton(
    String label,
    String filterName,
    bool isDarkMode,
    String selectedLanguage,
  ) {
    final isSelected = _selectedFilter == filterName;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = filterName;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: isSelected
              ? const Color(0xFF8b5cf6)
              : (isDarkMode ? const Color(0xFF1a1a1a) : Colors.grey[100]),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF8b5cf6)
                : (isDarkMode
                    ? Colors.grey[800]!
                    : Colors.grey[200]!),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF8b5cf6).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? Colors.white
                : (isDarkMode ? Colors.grey[400] : Colors.grey[700]),
          ),
        ),
      ),
    );
  }

  Widget _buildMentorCard(
    Map<String, dynamic> mentor,
    int index,
    bool isDarkMode,
    String selectedLanguage,
    Color textColor,
    Color? cardBgColor,
    Color? borderColor,
    Color? subtextColor,
  ) {
    final specialty =
        selectedLanguage == 'es' ? mentor['specialty'] : mentor['specialtyEn'];
    final expertise =
        selectedLanguage == 'es' ? mentor['expertise'] : mentor['expertiseEn'];
    final description = selectedLanguage == 'es'
        ? mentor['description']
        : mentor['descriptionEn'];
    final buttonText =
        selectedLanguage == 'es' ? 'Conectar' : 'Connect';

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor!, width: 1.5),
        color: cardBgColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.15 : 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mentor Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMentorAvatar(mentor['image']),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mentor['name'],
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        specialty,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: subtextColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.amber.withOpacity(0.1),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${mentor['rating']}',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Expertise Tags
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                expertise.length,
                (i) => Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF8b5cf6).withOpacity(0.1),
                    border: Border.all(
                      color: const Color(0xFF8b5cf6).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    expertise[i],
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF8b5cf6),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Description
            Text(
              description,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: subtextColor,
                height: 1.5,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),

            // Connect Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563eb),
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  shadowColor: const Color(0xFF2563eb).withOpacity(0.3),
                ),
                child: Text(
                  buttonText,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .slideY(
          begin: 0.4,
          duration: 500.ms,
          delay: Duration(milliseconds: 200 + (index * 80)),
        )
        .fadeIn();
  }

  Widget _buildMentorAvatar(String imageUrl) {
    return ClipOval(
      child: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFF8b5cf6).withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Image.network(
          imageUrl,
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
                size: 32,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
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
  final List<Map<String, dynamic>> notifications;
  final Function(List<Map<String, dynamic>>) onNotificationsChanged;

  const NotificationsScreen({
    super.key,
    required this.isDarkMode,
    required this.selectedLanguage,
    required this.textColor,
    required this.cardBgColor,
    required this.borderColor,
    required this.subtextColor,
    required this.getText,
    required this.notifications,
    required this.onNotificationsChanged,
  });

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<Map<String, dynamic>> notifications;

  @override
  void initState() {
    super.initState();
    notifications = List.from(widget.notifications);
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
          onPressed: () {
            widget.onNotificationsChanged(notifications);
            Navigator.pop(context);
          },
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
                  onLongPress: () =>
                      _showNotificationOptions(context, index, notification),
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