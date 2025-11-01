import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentoria/screens/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:mentoria/providers/theme_provider.dart';

class NavigationProvider {
  static final NavigationProvider _instance = NavigationProvider._internal();

  factory NavigationProvider() {
    return _instance;
  }

  NavigationProvider._internal();

  int _selectedTabIndex = 0;

  int get selectedTabIndex => _selectedTabIndex;

  void setTabIndex(int index) {
    _selectedTabIndex = index;
  }
}

class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  String _selectedCategory = 'all';

  final List<Map<String, dynamic>> recommendations = const [
    {
      'title': 'Mejora tu Técnica de Estudio',
      'description': 'Aprende métodos efectivos para optimizar tu tiempo',
      'titleEn': 'Improve Your Study Technique',
      'descriptionEn': 'Learn effective methods to optimize your study time',
      'icon': Icons.lightbulb,
      'color': 0xFFFFB84D,
      'category': 'study',
    },
    {
      'title': 'Gestión del Estrés',
      'description': 'Técnicas comprobadas para manejar la presión',
      'titleEn': 'Stress Management',
      'descriptionEn': 'Proven techniques to handle academic pressure',
      'icon': Icons.spa,
      'color': 0xFF4ECDC4,
      'category': 'wellness',
    },
    {
      'title': 'Habilidades de Comunicación',
      'description': 'Mejora tus presentaciones y expresión oral',
      'titleEn': 'Communication Skills',
      'descriptionEn': 'Improve your presentations and speaking',
      'icon': Icons.mic,
      'color': 0xFF95E1D3,
      'category': 'skills',
    },
    {
      'title': 'Planificación Académica',
      'description': 'Organiza tus tareas y metas de forma efectiva',
      'titleEn': 'Academic Planning',
      'descriptionEn': 'Organize your tasks and goals effectively',
      'icon': Icons.calendar_today,
      'color': 0xFF6C5CE7,
      'category': 'planning',
    },
    {
      'title': 'Colaboración y Trabajo en Equipo',
      'description': 'Estrategias para trabajar mejor en grupos',
      'titleEn': 'Collaboration and Teamwork',
      'descriptionEn': 'Strategies for better group work',
      'icon': Icons.people,
      'color': 0xFF00B894,
      'category': 'teamwork',
    },
    {
      'title': 'Desarrollo de Liderazgo',
      'description': 'Conviértete en un líder efectivo y competente',
      'titleEn': 'Leadership Development',
      'descriptionEn': 'Become an effective leader',
      'icon': Icons.trending_up,
      'color': 0xFFFF7675,
      'category': 'leadership',
    },
  ];

  final Map<String, Map<String, String>> texts = {
    'es': {
      'title': 'Recomendaciones',
      'subtitle': 'Potencia tu desempeño académico',
      'filterAll': 'Todas',
      'filterStudy': 'Estudio',
      'filterWellness': 'Bienestar',
      'filterSkills': 'Habilidades',
      'notificaciones': 'Notificaciones',
      'sinNotificaciones': 'No hay notificaciones',
      'marcarLeida': 'Marcar como leída',
      'marcarNoLeida': 'Marcar como no leída',
      'eliminar': 'Eliminar',
    },
    'en': {
      'title': 'Recommendations',
      'subtitle': 'Boost your academic performance',
      'filterAll': 'All',
      'filterStudy': 'Study',
      'filterWellness': 'Wellness',
      'filterSkills': 'Skills',
      'notificaciones': 'Notifications',
      'sinNotificaciones': 'No notifications',
      'marcarLeida': 'Mark as read',
      'marcarNoLeida': 'Mark as unread',
      'eliminar': 'Delete',
    },
  };

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

  String getText(String key, String language) {
    return texts[language]?[key] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        final isDarkMode = themeProvider.isDarkMode;
        final selectedLanguage = themeProvider.selectedLanguage;
        final bgColor = isDarkMode ? const Color(0xFF0f0f0f) : Colors.white;
        final textColor = isDarkMode ? Colors.white : const Color(0xFF0b1e6b);
        final subtextColor =
            isDarkMode ? Colors.grey[500] : Colors.grey[600];
        final cardBgColor =
            isDarkMode ? const Color(0xFF1a1a1a) : Colors.grey[50];
        final borderColor =
            isDarkMode ? Colors.grey[800] : Colors.grey[100];

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
                            : [const Color(0xFF8b5cf6).withOpacity(0.08),
                                Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border(
                        bottom: BorderSide(color: borderColor!, width: 1),
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

                  // Filter Buttons
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildCategoryButton(
                            getText('filterAll', selectedLanguage),
                            'all',
                            isDarkMode,
                          ),
                          const SizedBox(width: 10),
                          _buildCategoryButton(
                            getText('filterStudy', selectedLanguage),
                            'study',
                            isDarkMode,
                          ),
                          const SizedBox(width: 10),
                          _buildCategoryButton(
                            getText('filterWellness', selectedLanguage),
                            'wellness',
                            isDarkMode,
                          ),
                          const SizedBox(width: 10),
                          _buildCategoryButton(
                            getText('filterSkills', selectedLanguage),
                            'skills',
                            isDarkMode,
                          ),
                        ],
                      ),
                    ),
                  ).animate()
                      .slideY(begin: -0.3, duration: 500.ms, delay: 100.ms),

                  // Recommendations Grid
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.88,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                      ),
                      itemCount: recommendations.length,
                      itemBuilder: (context, index) {
                        final rec = recommendations[index];
                        final isVisible = _selectedCategory == 'all' ||
                            _selectedCategory == rec['category'];

                        if (!isVisible) {
                          return SizedBox.shrink();
                        }

                        return _buildRecommendationCard(
                          rec,
                          index,
                          isDarkMode,
                          textColor,
                          selectedLanguage,
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

  Widget _buildCategoryButton(
    String label,
    String category,
    bool isDarkMode,
  ) {
    final isSelected = _selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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

  Widget _buildRecommendationCard(
    Map<String, dynamic> rec,
    int index,
    bool isDarkMode,
    Color textColor,
    String selectedLanguage,
    Color? subtextColor,
  ) {
    final title = selectedLanguage == 'es' ? rec['title'] : rec['titleEn'];
    final description =
        selectedLanguage == 'es' ? rec['description'] : rec['descriptionEn'];
    final cardColor = Color(rec['color']);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            cardColor.withOpacity(isDarkMode ? 0.15 : 0.08),
            cardColor.withOpacity(isDarkMode ? 0.08 : 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: cardColor.withOpacity(isDarkMode ? 0.3 : 0.25),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: cardColor.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon Container
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        cardColor,
                        cardColor.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: cardColor.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    rec['icon'],
                    color: Colors.white,
                    size: 28,
                  ),
                ),

                // Content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                        letterSpacing: -0.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: subtextColor,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),

                // Arrow Indicator
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cardColor.withOpacity(0.2),
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: cardColor,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
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

  @override
  void dispose() {
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