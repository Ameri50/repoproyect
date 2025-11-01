import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mentoria/providers/theme_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;
  bool _isEditingProfile = false;

  final Map<String, Map<String, String>> texts = {
    'es': {
      'perfil': 'Mi Perfil',
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
      'ayuda': 'Centro de Ayuda',
      'centroAyuda': 'Centro de Ayuda',
      'centroAyudaSub': 'Preguntas frecuentes',
      'comentarios': 'Comentarios',
      'comentariosSub': 'Cuéntanos tu experiencia',
      'acerca': 'Acerca de',
      'acercaSub': 'Versión 1.0.0',
      'cerrarSesion': 'Cerrar Sesión',
      'correoNotificaciones': 'Notificaciones por Correo',
      'notificacionesCorreoSub': 'Recibe actualizaciones por correo',
      'notificacionesPush': 'Notificaciones Push',
      'notificacionesPushSub': 'Alertas en tu dispositivo',
      'configuracionCompleta': 'Configuración Completa',
      'controlPrivacidad': 'Control de Privacidad',
      'datos': 'Datos',
      'datosSub': 'Administra tus datos personales',
      'compartirDatos': 'Compartir datos con terceros',
      'cancelar': 'Cancelar',
      'aceptar': 'Aceptar',
      'editarPerfil': 'Editar Perfil',
      'guardarCambios': 'Guardar Cambios',
      'nombre': 'Nombre',
      'bio': 'Biografía',
      'cambiarFoto': 'Cambiar Foto',
      'tomarFoto': 'Tomar Foto',
      'seleccionarGaleria': 'Seleccionar de Galería',
      'preguntasFrecuentes': 'Preguntas Frecuentes',
      'enviarComentarios': 'Enviar Comentarios',
      'tuComentario': 'Tu comentario',
      'enviar': 'Enviar',
      'acercaDe': 'Acerca de MentoriA',
      'descripcion': 'Descripción',
      'version': 'Versión',
      'desarrollador': 'Desarrollador',
      'pregunta1': '¿Cómo edito mi perfil?',
      'respuesta1': 'Haz clic en el icono de editar en la pantalla de perfil y modifica tus datos.',
      'pregunta2': '¿Cómo cambio mi foto de perfil?',
      'respuesta2': 'En modo edición, haz clic en la cámara de tu avatar para tomar o seleccionar una foto.',
      'pregunta3': '¿Cómo cambio el idioma?',
      'respuesta3': 'Ve a Preferencias > Idioma y selecciona tu idioma preferido.',
      'pregunta4': '¿Cómo activo el modo oscuro?',
      'respuesta4': 'Ve a Preferencias > Apariencia y activa el modo oscuro.',
      'modoClaro': 'Modo Claro',
      'modoOscuro': 'Modo Oscuro',
      'modoAdaptativo': 'Modo Adaptativo',
      'modoAdaptativoDesc': 'Cambiar según la hora del día',
      'restablecer': 'Restablecer Preferencias',
      'restablecerDesc': 'Volver a los ajustes predeterminados',
    },
    'en': {
      'perfil': 'My Profile',
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
      'ayuda': 'Help Center',
      'centroAyuda': 'Help Center',
      'centroAyudaSub': 'Frequently asked questions',
      'comentarios': 'Feedback',
      'comentariosSub': 'Tell us about your experience',
      'acerca': 'About',
      'acercaSub': 'Version 1.0.0',
      'cerrarSesion': 'Logout',
      'correoNotificaciones': 'Email Notifications',
      'notificacionesCorreoSub': 'Receive email updates',
      'notificacionesPush': 'Push Notifications',
      'notificacionesPushSub': 'Device alerts',
      'configuracionCompleta': 'Complete Settings',
      'controlPrivacidad': 'Privacy Control',
      'datos': 'Data',
      'datosSub': 'Manage your personal data',
      'cancelar': 'Cancel',
      'aceptar': 'Accept',
      'editarPerfil': 'Edit Profile',
      'guardarCambios': 'Save Changes',
      'nombre': 'Name',
      'bio': 'Biography',
      'cambiarFoto': 'Change Photo',
      'tomarFoto': 'Take Photo',
      'seleccionarGaleria': 'Select from Gallery',
      'preguntasFrecuentes': 'Frequently Asked Questions',
      'enviarComentarios': 'Send Feedback',
      'tuComentario': 'Your feedback',
      'enviar': 'Send',
      'acercaDe': 'About MentoriA',
      'descripcion': 'Description',
      'version': 'Version',
      'desarrollador': 'Developer',
      'pregunta1': 'How do I edit my profile?',
      'respuesta1': 'Click the edit icon on the profile screen and modify your data.',
      'pregunta2': 'How do I change my profile photo?',
      'respuesta2': 'In edit mode, click the camera on your avatar to take or select a photo.',
      'pregunta3': 'How do I change the language?',
      'respuesta3': 'Go to Preferences > Language and select your preferred language.',
      'pregunta4': 'How do I enable dark mode?',
      'respuesta4': 'Go to Preferences > Appearance and enable dark mode.',
      'modoClaro': 'Light Mode',
      'modoOscuro': 'Dark Mode',
      'modoAdaptativo': 'Adaptive Mode',
      'modoAdaptativoDesc': 'Change based on time of day',
    },
  };

  String getText(String key, String language) {
    return texts[language]?[key] ?? '';
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: getText('estudiante', 'es'));
    _emailController = TextEditingController(text: getText('email', 'es'));
    _bioController = TextEditingController(text: 'Estudiante apasionado por el aprendizaje');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  void _showImagePickerOptions(BuildContext context, String selectedLanguage) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFF8b5cf6)),
              title: Text(
                getText('tomarFoto', selectedLanguage),
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              onTap: () => _pickImage(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.image, color: Color(0xFF8b5cf6)),
              title: Text(
                getText('seleccionarGaleria', selectedLanguage),
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              onTap: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        final isDarkMode = themeProvider.isDarkMode;
        final selectedLanguage = themeProvider.selectedLanguage;
        final bgColor = isDarkMode ? const Color(0xFF0f1419) : const Color(0xFFF5F7FA);
        final textColor = isDarkMode ? Colors.white : const Color(0xFF1a1a2e);
        final cardColor = isDarkMode ? const Color(0xFF1e2139) : Colors.white;
        final borderColor = isDarkMode ? Colors.grey[800] : Colors.grey[300];

        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: bgColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: textColor),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              getText('perfil', selectedLanguage),
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _isEditingProfile = !_isEditingProfile;
                  });
                },
                icon: Icon(
                  _isEditingProfile ? Icons.check : Icons.edit,
                  color: const Color(0xFF8b5cf6),
                  size: 24,
                ),
              ),
              IconButton(
                onPressed: () => _showPreferencesModal(context, themeProvider),
                icon: const Icon(Icons.settings, size: 24),
                color: isDarkMode ? Colors.grey[400] : Colors.grey,
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: cardColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                      border: Border.all(color: borderColor!, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF8b5cf6), Color(0xFF06b6d4)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: ClipOval(
                                child: _profileImage != null
                                    ? Image.file(
                                        _profileImage!,
                                        width: 110,
                                        height: 110,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        'https://api.dicebear.com/7.x/avataaars/svg?seed=Felix',
                                        width: 110,
                                        height: 110,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            width: 110,
                                            height: 110,
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
                                              size: 60,
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ),
                            if (_isEditingProfile)
                              GestureDetector(
                                onTap: () => _showImagePickerOptions(
                                    context, selectedLanguage),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [Color(0xFF8b5cf6), Color(0xFF06b6d4)],
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        if (_isEditingProfile)
                          Column(
                            children: [
                              _buildModernTextField(
                                controller: _nameController,
                                hintText: getText('nombre', selectedLanguage),
                                isDarkMode: isDarkMode,
                                textColor: textColor,
                                cardColor: cardColor,
                              ),
                              const SizedBox(height: 12),
                              _buildModernTextField(
                                controller: _emailController,
                                hintText: 'Email',
                                isDarkMode: isDarkMode,
                                textColor: textColor,
                                cardColor: cardColor,
                              ),
                              const SizedBox(height: 12),
                              _buildModernTextField(
                                controller: _bioController,
                                hintText: getText('bio', selectedLanguage),
                                isDarkMode: isDarkMode,
                                textColor: textColor,
                                cardColor: cardColor,
                                maxLines: 3,
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _isEditingProfile = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(getText('guardarCambios', selectedLanguage)),
                                        backgroundColor: const Color(0xFF8b5cf6),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        margin: const EdgeInsets.all(16),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF8b5cf6),
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    getText('guardarCambios', selectedLanguage),
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        else
                          Column(
                            children: [
                              Text(
                                _nameController.text,
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _emailController.text,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: isDarkMode
                                      ? Colors.grey[400]
                                      : Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _bioController.text,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: isDarkMode
                                      ? Colors.grey[300]
                                      : Colors.grey[600],
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green.withOpacity(0.1),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                getText('activo', selectedLanguage),
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ).animate().slideY(begin: 0.3, duration: 600.ms, delay: 100.ms),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getText('estadisticas', selectedLanguage),
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _buildModernStatCard(
                              getText('diasActivos', selectedLanguage),
                              '45',
                              const Color(0xFF8b5cf6),
                              isDarkMode,
                              cardColor,
                              textColor,
                            ),
                            const SizedBox(width: 12),
                            _buildModernStatCard(
                              getText('tareas', selectedLanguage),
                              '28',
                              const Color(0xFF06b6d4),
                              isDarkMode,
                              cardColor,
                              textColor,
                            ),
                            const SizedBox(width: 12),
                            _buildModernStatCard(
                              getText('logros', selectedLanguage),
                              '12',
                              const Color(0xFF00B894),
                              isDarkMode,
                              cardColor,
                              textColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).animate().slideY(begin: 0.3, duration: 600.ms, delay: 200.ms),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getText('ayuda', selectedLanguage),
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildModernMenuItem(
                          icon: Icons.help_center,
                          title: getText('centroAyuda', selectedLanguage),
                          subtitle: getText('centroAyudaSub', selectedLanguage),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HelpCenterScreen(
                                  getText: getText,
                                ),
                              ),
                            );
                          },
                          isDarkMode: isDarkMode,
                          textColor: textColor,
                          cardColor: cardColor,
                          borderColor: borderColor,
                        ),
                        _buildModernMenuItem(
                          icon: Icons.feedback,
                          title: getText('comentarios', selectedLanguage),
                          subtitle: getText('comentariosSub', selectedLanguage),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FeedbackScreen(
                                  getText: getText,
                                ),
                              ),
                            );
                          },
                          isDarkMode: isDarkMode,
                          textColor: textColor,
                          cardColor: cardColor,
                          borderColor: borderColor,
                        ),
                        _buildModernMenuItem(
                          icon: Icons.info,
                          title: getText('acerca', selectedLanguage),
                          subtitle: getText('acercaSub', selectedLanguage),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AboutScreen(
                                  getText: getText,
                                ),
                              ),
                            );
                          },
                          isDarkMode: isDarkMode,
                          textColor: textColor,
                          cardColor: cardColor,
                          borderColor: borderColor,
                        ),
                      ],
                    ),
                  ).animate().slideY(begin: 0.3, duration: 600.ms, delay: 300.ms),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.withOpacity(0.1),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: Colors.red.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Text(
                          getText('cerrarSesion', selectedLanguage),
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ).animate().scale(duration: 600.ms, delay: 400.ms),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String hintText,
    required bool isDarkMode,
    required Color textColor,
    required Color? cardColor,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: textColor,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
        ),
        filled: true,
        fillColor: isDarkMode ? Colors.grey[900] : Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildModernStatCard(
    String label,
    String value,
    Color color,
    bool isDarkMode,
    Color? cardColor,
    Color textColor,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDarkMode ? 0.2 : 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernMenuItem({
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
          borderRadius: BorderRadius.circular(14),
          color: cardColor,
          border: Border.all(color: borderColor!, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDarkMode ? 0.1 : 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF8b5cf6), Color(0xFF06b6d4)],
                ),
              ),
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: isDarkMode ? Colors.grey[500] : Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  void _showPreferencesModal(BuildContext context, ThemeProvider themeProvider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Consumer<ThemeProvider>(
          builder: (context, provider, _) {
            final isDarkMode = provider.isDarkMode;
            final selectedLanguage = provider.selectedLanguage;
            final bgColor = isDarkMode ? const Color(0xFF1e2139) : Colors.white;
            final textColor = isDarkMode ? Colors.white : const Color(0xFF1a1a2e);
            final cardColor = isDarkMode ? const Color(0xFF1e2139) : Colors.white;
            final borderColor = isDarkMode ? Colors.grey[800] : Colors.grey[300];

            return StatefulBuilder(
              builder: (context, setStateModal) {
                bool emailNotif = true;
                bool pushNotif = true;
                bool dataSharing = false;
                bool analytics = true;

                return Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            getText('preferencias', selectedLanguage),
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            getText('notificaciones', selectedLanguage),
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildPreferenceSwitch(
                            label: getText('correoNotificaciones', selectedLanguage),
                            value: emailNotif,
                            onChanged: (value) {
                              setStateModal(() {
                                emailNotif = value;
                              });
                            },
                            isDarkMode: isDarkMode,
                            textColor: textColor,
                            cardColor: cardColor,
                            borderColor: borderColor,
                          ),
                          const SizedBox(height: 10),
                          _buildPreferenceSwitch(
                            label: getText('notificacionesPush', selectedLanguage),
                            value: pushNotif,
                            onChanged: (value) {
                              setStateModal(() {
                                pushNotif = value;
                              });
                            },
                            isDarkMode: isDarkMode,
                            textColor: textColor,
                            cardColor: cardColor,
                            borderColor: borderColor,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            getText('idioma', selectedLanguage),
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: cardColor,
                              border: Border.all(color: borderColor!),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedLanguage == 'es' ? 'Español' : 'English',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: textColor,
                                  ),
                                ),
                                PopupMenuButton<String>(
                                  onSelected: (value) {
                                    provider.setLanguage(value);
                                  },
                                  itemBuilder: (BuildContext context) => [
                                    PopupMenuItem(
                                      value: 'es',
                                      child: Text(
                                        'Español',
                                        style: GoogleFonts.poppins(),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 'en',
                                      child: Text(
                                        'English',
                                        style: GoogleFonts.poppins(),
                                      ),
                                    ),
                                  ],
                                  child: const Icon(Icons.arrow_drop_down),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            getText('apariencia', selectedLanguage),
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildThemeModeButtonWidget(
                            label: getText('modoClaro', selectedLanguage),
                            icon: Icons.light_mode,
                            isSelected: !isDarkMode && !provider.isAdaptiveMode,
                            onTap: () => provider.setThemeMode(ThemeMode.light),
                            isDarkMode: isDarkMode,
                            textColor: textColor,
                            cardColor: cardColor,
                            borderColor: borderColor,
                          ),
                          const SizedBox(height: 10),
                          _buildThemeModeButtonWidget(
                            label: getText('modoOscuro', selectedLanguage),
                            icon: Icons.dark_mode,
                            isSelected: isDarkMode && !provider.isAdaptiveMode,
                            onTap: () => provider.setThemeMode(ThemeMode.dark),
                            isDarkMode: isDarkMode,
                            textColor: textColor,
                            cardColor: cardColor,
                            borderColor: borderColor,
                          ),
                          const SizedBox(height: 10),
                          _buildThemeModeButtonWidget(
                            label: getText('modoAdaptativo', selectedLanguage),
                            subtitle: getText('modoAdaptativoDesc', selectedLanguage),
                            icon: Icons.brightness_auto,
                            isSelected: provider.isAdaptiveMode,
                            onTap: () => provider.setAdaptiveMode(true),
                            isDarkMode: isDarkMode,
                            textColor: textColor,
                            cardColor: cardColor,
                            borderColor: borderColor,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            getText('privacidad', selectedLanguage),
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildPreferenceSwitch(
                            label: getText('compartirDatos', selectedLanguage),
                            value: dataSharing,
                            onChanged: (value) {
                              setStateModal(() {
                                dataSharing = value;
                              });
                            },
                            isDarkMode: isDarkMode,
                            textColor: textColor,
                            cardColor: cardColor,
                            borderColor: borderColor,
                          ),
                          const SizedBox(height: 10),
                          _buildPreferenceSwitch(
                            label: getText('datos', selectedLanguage),
                            value: analytics,
                            onChanged: (value) {
                              setStateModal(() {
                                analytics = value;
                              });
                            },
                            isDarkMode: isDarkMode,
                            textColor: textColor,
                            cardColor: cardColor,
                            borderColor: borderColor,
                          ),
                          const SizedBox(height: 28),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildThemeModeButtonWidget({
    required String label,
    String? subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDarkMode,
    required Color textColor,
    required Color cardColor,
    required Color? borderColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: cardColor,
          border: Border.all(
            color: isSelected ? const Color(0xFF8b5cf6) : borderColor!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF8b5cf6).withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: isSelected
                      ? [const Color(0xFF8b5cf6), const Color(0xFF06b6d4)]
                      : [Colors.grey[400]!, Colors.grey[500]!],
                ),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: isDarkMode ? Colors.grey[500] : Colors.grey[500],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF8b5cf6), Color(0xFF06b6d4)],
                  ),
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 14,
                ),
              )
            else
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDarkMode ? Colors.grey[600]! : Colors.grey[400]!,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferenceSwitch({
    required String label,
    required bool value,
    required Function(bool) onChanged,
    required bool isDarkMode,
    required Color textColor,
    required Color? cardColor,
    required Color? borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: cardColor,
        border: Border.all(color: borderColor!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: const Color(0xFF8b5cf6),
          ),
        ],
      ),
    );
  }
}

class HelpCenterScreen extends StatelessWidget {
  final Function getText;

  const HelpCenterScreen({
    super.key,
    required this.getText,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        final isDarkMode = themeProvider.isDarkMode;
        final selectedLanguage = themeProvider.selectedLanguage;
        final bgColor = isDarkMode ? const Color(0xFF0f1419) : const Color(0xFFF5F7FA);
        final textColor = isDarkMode ? Colors.white : const Color(0xFF1a1a2e);
        final cardColor = isDarkMode ? const Color(0xFF1e2139) : Colors.white;
        final borderColor = isDarkMode ? Colors.grey[800] : Colors.grey[300];

        final faqs = [
          {'q': 'pregunta1', 'a': 'respuesta1'},
          {'q': 'pregunta2', 'a': 'respuesta2'},
          {'q': 'pregunta3', 'a': 'respuesta3'},
          {'q': 'pregunta4', 'a': 'respuesta4'},
        ];

        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: bgColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: textColor),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              getText('centroAyuda', selectedLanguage),
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: faqs.length,
            itemBuilder: (context, index) {
              final faq = faqs[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: cardColor,
                  border: Border.all(color: borderColor!, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDarkMode ? 0.1 : 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF8b5cf6),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            getText(faq['q'], selectedLanguage),
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        getText(faq['a'], selectedLanguage),
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: isDarkMode ? Colors.grey[300] : Colors.grey[600],
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate().slideY(
                begin: 0.3,
                duration: 600.ms,
                delay: Duration(milliseconds: 100 * index),
              );
            },
          ),
        );
      },
    );
  }
}

class FeedbackScreen extends StatefulWidget {
  final Function getText;

  const FeedbackScreen({
    super.key,
    required this.getText,
  });

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  late TextEditingController _feedbackController;

  @override
  void initState() {
    super.initState();
    _feedbackController = TextEditingController();
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        final isDarkMode = themeProvider.isDarkMode;
        final selectedLanguage = themeProvider.selectedLanguage;
        final bgColor = isDarkMode ? const Color(0xFF0f1419) : const Color(0xFFF5F7FA);
        final textColor = isDarkMode ? Colors.white : const Color(0xFF1a1a2e);
        final borderColor = isDarkMode ? Colors.grey[800] : Colors.grey[300];

        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: bgColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: textColor),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              widget.getText('comentarios', selectedLanguage),
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.getText('tuComentario', selectedLanguage),
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Nos encantaría escuchar tus sugerencias y comentarios',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _feedbackController,
                  maxLines: 8,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: textColor,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.getText('tuComentario', selectedLanguage),
                    hintStyle: GoogleFonts.poppins(
                      color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
                    ),
                    filled: true,
                    fillColor: isDarkMode ? Colors.grey[900] : Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: borderColor!),
                    ),
                    contentPadding: const EdgeInsets.all(18),
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_feedbackController.text.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              widget.getText('guardarCambios', selectedLanguage),
                            ),
                            backgroundColor: const Color(0xFF8b5cf6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.all(16),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8b5cf6),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      widget.getText('enviar', selectedLanguage),
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
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
}

class AboutScreen extends StatelessWidget {
  final Function getText;

  const AboutScreen({
    super.key,
    required this.getText,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        final isDarkMode = themeProvider.isDarkMode;
        final selectedLanguage = themeProvider.selectedLanguage;
        final bgColor = isDarkMode ? const Color(0xFF0f1419) : const Color(0xFFF5F7FA);
        final textColor = isDarkMode ? Colors.white : const Color(0xFF1a1a2e);
        final cardColor = isDarkMode ? const Color(0xFF1e2139) : Colors.white;
        final borderColor = isDarkMode ? Colors.grey[800] : Colors.grey[300];

        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: bgColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: textColor),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              getText('acerca', selectedLanguage),
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: cardColor,
                    border: Border.all(color: borderColor!, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDarkMode ? 0.2 : 0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Color(0xFF8b5cf6), Color(0xFF06b6d4)],
                          ),
                        ),
                        child: const Icon(
                          Icons.school,
                          color: Colors.white,
                          size: 45,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'MentoriA',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        getText('acercaSub', selectedLanguage),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  'Sobre Nosotros',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'MentoriA es una plataforma inteligente de mentoría diseñada para ayudarte en tu viaje académico. Con características innovadoras y un enfoque centrado en el estudiante, te proporcionamos las herramientas que necesitas para tener éxito.',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: isDarkMode ? Colors.grey[300] : Colors.grey[600],
                    height: 1.8,
                  ),
                ),
                const SizedBox(height: 28),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: cardColor,
                    border: Border.all(color: borderColor),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getText('version', selectedLanguage),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                          Text(
                            '1.0.0',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF8b5cf6),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Divider(
                        color: borderColor,
                        height: 1,
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getText('desarrollador', selectedLanguage),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                          Text(
                            'MentoriA Team',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF8b5cf6),
                            ),
                          ),
                        ],
                      ),
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