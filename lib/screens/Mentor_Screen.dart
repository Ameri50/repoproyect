import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mentoria/providers/theme_provider.dart';

class MentorScreen extends StatefulWidget {
  const MentorScreen({super.key});

  @override
  State<MentorScreen> createState() => _MentorScreenState();
}

class _MentorScreenState extends State<MentorScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'Todos';

  final Map<String, Map<String, String>> texts = {
    'es': {
      'title': 'Mentor Connect',
      'subtitle': 'Encuentra un Mentor',
      'searchPlaceholder': 'Buscar mentores...',
      'filterAll': 'Todos los Mentores',
      'filterAcademic': 'Apoyo Académico',
      'filterEmotional': 'Emocional',
      'buttonConnect': 'Conectar',
    },
    'en': {
      'title': 'Mentor Connect',
      'subtitle': 'Find a Mentor',
      'searchPlaceholder': 'Search mentors...',
      'filterAll': 'All Mentors',
      'filterAcademic': 'Academic Support',
      'filterEmotional': 'Emotional',
      'buttonConnect': 'Connect',
    },
  };

  String getText(String key, String language) {
    return texts[language]?[key] ?? '';
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
          'Experiencia en ayudar a estudiantes con focus en gestión académica y manejo del estrés en los primeros semestres.',
      'descriptionEn':
          'Experience helping students focus on academic management and stress handling in early semesters.',
      'image': 'https://api.dicebear.com/7.x/avataaars/svg?seed=Aruya',
    },
    {
      'name': 'Mark Johnson',
      'specialty': 'Entrenador de Escritura Académica',
      'specialtyEn': 'Academic Writing Coach',
      'rating': 4.9,
      'expertise': ['Escritura Académica', 'Orientación de Carreras'],
      'expertiseEn': ['Academic Writing', 'Career Guidance'],
      'description':
          'Chief educator focused on helping students develop strong academic writing skills and career guidance for a brighter future.',
      'descriptionEn':
          'Chief educator focused on helping students develop strong academic writing skills and career guidance for a brighter future.',
      'image': 'https://api.dicebear.com/7.x/avataaars/svg?seed=Mark',
    },
    {
      'name': 'Sarah Lee',
      'specialty': 'Especialista en Gestión del Tiempo',
      'specialtyEn': 'Time Management Specialist',
      'rating': 4.7,
      'expertise': ['Productividad', 'Data Skills', 'Habilidades blandas'],
      'expertiseEn': ['Productivity', 'Data Skills', 'Soft Skills'],
      'description':
          'Especialista en productividad y manejo del tiempo. Ayuda a estudiantes con técnicas para aprovechar mejor el tiempo de estudio.',
      'descriptionEn':
          'Specialist in productivity and time management. Helps students with techniques to make the most of study time.',
      'image': 'https://api.dicebear.com/7.x/avataaars/svg?seed=Sarah',
    },
    {
      'name': 'David Chen',
      'specialty': 'Asesor de Desarrollo de Carrera',
      'specialtyEn': 'Career Development Advisor',
      'rating': 4.6,
      'expertise': ['Desarrollo de Carrera', 'Habilidades de Liderazgo'],
      'expertiseEn': ['Career Development', 'Leadership Skills'],
      'description':
          'Especializado en desarrollo de carrera y habilidades de liderazgo. Ayuda a estudiantes a navegar y decidir sobre opciones de carrera.',
      'descriptionEn':
          'Specialized in career development and leadership skills. Helps students navigate and decide on career options.',
      'image': 'https://api.dicebear.com/7.x/avataaars/svg?seed=David',
    },
  ];

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
        final subtextColor = isDarkMode ? Colors.grey[400] : Colors.grey;

        return Container(
          color: bgColor,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
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

                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: TextField(
                      controller: _searchController,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: textColor,
                      ),
                      decoration: InputDecoration(
                        hintText: getText('searchPlaceholder', selectedLanguage),
                        hintStyle: GoogleFonts.poppins(
                          color: subtextColor,
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: isDarkMode ? Colors.grey[600] : Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: borderColor!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                            color: Color(0xFF8b5cf6),
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: isDarkMode ? const Color(0xFF2a2a2a) : Colors.grey[50],
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ).animate()
                      .slideY(begin: -0.3, duration: 600.ms, delay: 100.ms),

                  // Filter Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                          const SizedBox(width: 8),
                          _buildFilterButton(
                            getText('filterAcademic', selectedLanguage),
                            'Academico',
                            isDarkMode,
                            selectedLanguage,
                          ),
                          const SizedBox(width: 8),
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
                      .slideX(begin: -0.5, duration: 600.ms, delay: 200.ms),

                  // Mentors List
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected
              ? const Color(0xFF8b5cf6)
              : (isDarkMode ? const Color(0xFF2a2a2a) : Colors.grey[200]),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? Colors.white
                : (isDarkMode ? Colors.grey[300] : Colors.grey[700]),
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
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor!),
        color: cardBgColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDarkMode ? 0.2 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mentor Header with Avatar and Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Image.network(
                  mentor['image'],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF8b5cf6), Color(0xFF06b6d4)],
                        ),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mentor['name'],
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    Text(
                      specialty,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: subtextColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${mentor['rating']}',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Expertise Tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
              expertise.length,
              (i) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isDarkMode ? const Color(0xFF1a1a1a) : Colors.grey[100],
                ),
                child: Text(
                  expertise[i],
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Description
          Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: subtextColor,
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),

          // Connect Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563eb),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                buttonText,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().slideY(
      begin: 0.3,
      duration: 600.ms,
      delay: Duration(milliseconds: 300 + (index * 100)),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}