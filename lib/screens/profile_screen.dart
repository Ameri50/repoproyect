import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mentoria/providers/theme_provider.dart';
import 'package:mentoria/providers/user_provider.dart';
import 'package:mentoria/services/auth_service.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();
  
  File? _profileImage;
  bool _isEditing = false;
  bool _isLoading = false;
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _shareData = false;
  bool _personalData = false;
  bool _hasLoadedData = false;

  @override
  void initState() {
    super.initState();
    // No cargamos aquí, se carga en didChangeDependencies
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Solo carga una vez
    if (!_hasLoadedData) {
      _updateControllers();
      _hasLoadedData = true;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _updateControllers() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.user != null) {
      _nameController.text = userProvider.user?.fullName ?? '';
      _emailController.text = userProvider.user?.email ?? '';
      _bioController.text = userProvider.user?.bio ?? '';
    }
  }

  Future<void> _pickImage() async {
    if (!mounted) return;
    
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext modalContext) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: themeProvider.isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Cambiar foto de perfil',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              _buildImageSourceOption(
                modalContext,
                icon: Icons.camera_alt,
                title: 'Cámara',
                source: ImageSource.camera,
              ),
              const SizedBox(height: 10),
              _buildImageSourceOption(
                modalContext,
                icon: Icons.photo_library,
                title: 'Galería',
                source: ImageSource.gallery,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageSourceOption(
    BuildContext modalContext, {
    required IconData icon,
    required String title,
    required ImageSource source,
  }) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    
    return InkWell(
      onTap: () async {
        Navigator.pop(modalContext);
        final ImagePicker picker = ImagePicker();
        final XFile? pickedFile = await picker.pickImage(source: source);
        
        if (pickedFile != null && mounted) {
          setState(() {
            _profileImage = File(pickedFile.path);
          });
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode 
              ? Colors.grey.withOpacity(0.1) 
              : Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      
      debugPrint('===== GUARDANDO PERFIL =====');
      debugPrint('Nombre: ${_nameController.text}');
      debugPrint('Bio: ${_bioController.text}');
      
      final updates = {
        'full_name': _nameController.text.trim(),
        'bio': _bioController.text.trim(),
      };
      
      debugPrint('Datos a enviar: $updates');
      debugPrint('Llamando a updateUserProfile...');
      
      await userProvider.updateUserProfile(updates);
      
      if (mounted) {
        debugPrint('✅ Perfil actualizado exitosamente');
        setState(() {
          _isEditing = false;
          _isLoading = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Perfil actualizado correctamente'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      debugPrint('❌ Error al guardar perfil: $e');
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al actualizar perfil: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _showPreferences() async {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext modalContext) {
        return StatefulBuilder(
          builder: (BuildContext statefulContext, StateSetter setModalState) {
            return Container(
              height: MediaQuery.of(modalContext).size.height * 0.7,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: themeProvider.isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Preferencias',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPreferenceSection(
                            title: 'Idioma',
                            child: _buildLanguageSelector(themeProvider),
                          ),
                          const SizedBox(height: 20),
                          _buildPreferenceSection(
                            title: 'Apariencia',
                            child: _buildThemeSelector(themeProvider),
                          ),
                          const SizedBox(height: 20),
                          _buildPreferenceSection(
                            title: 'Notificaciones',
                            child: Column(
                              children: [
                                _buildToggleOption(
                                  title: 'Notificaciones por email',
                                  value: _emailNotifications,
                                  onChanged: (value) {
                                    setModalState(() {
                                      _emailNotifications = value;
                                    });
                                  },
                                  themeProvider: themeProvider,
                                ),
                                const SizedBox(height: 12),
                                _buildToggleOption(
                                  title: 'Notificaciones push',
                                  value: _pushNotifications,
                                  onChanged: (value) {
                                    setModalState(() {
                                      _pushNotifications = value;
                                    });
                                  },
                                  themeProvider: themeProvider,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildPreferenceSection(
                            title: 'Privacidad',
                            child: Column(
                              children: [
                                _buildToggleOption(
                                  title: 'Compartir datos de uso',
                                  value: _shareData,
                                  onChanged: (value) {
                                    setModalState(() {
                                      _shareData = value;
                                    });
                                  },
                                  themeProvider: themeProvider,
                                ),
                                const SizedBox(height: 12),
                                _buildToggleOption(
                                  title: 'Personalizar datos',
                                  value: _personalData,
                                  onChanged: (value) {
                                    setModalState(() {
                                      _personalData = value;
                                    });
                                  },
                                  themeProvider: themeProvider,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPreferenceSection({
    required String title,
    required Widget child,
  }) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: themeProvider.isDarkMode 
                ? Colors.grey.withOpacity(0.1) 
                : Colors.grey.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
          child: child,
        ),
      ],
    );
  }

  Widget _buildLanguageSelector(ThemeProvider themeProvider) {
    return Row(
      children: [
        Expanded(
          child: _buildLanguageOption(
            'Español',
            themeProvider.language == 'es',
            () => themeProvider.toggleLanguage(),
            themeProvider,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildLanguageOption(
            'English',
            themeProvider.language == 'en',
            () => themeProvider.toggleLanguage(),
            themeProvider,
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageOption(
    String label,
    bool isSelected,
    VoidCallback onTap,
    ThemeProvider themeProvider,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue
              : (themeProvider.isDarkMode ? Colors.grey[800] : Colors.grey[200]),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              color: isSelected ? Colors.white : (themeProvider.isDarkMode ? Colors.white : Colors.black),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeSelector(ThemeProvider themeProvider) {
    return Row(
      children: [
        Expanded(
          child: _buildThemeOption(
            'Claro',
            Icons.light_mode,
            !themeProvider.isDarkMode,
            () => themeProvider.setDarkMode(false),
            themeProvider,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildThemeOption(
            'Oscuro',
            Icons.dark_mode,
            themeProvider.isDarkMode,
            () => themeProvider.setDarkMode(true),
            themeProvider,
          ),
        ),
      ],
    );
  }

  Widget _buildThemeOption(
    String label,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
    ThemeProvider themeProvider,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue
              : (themeProvider.isDarkMode ? Colors.grey[800] : Colors.grey[200]),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : (themeProvider.isDarkMode ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.poppins(
                color: isSelected ? Colors.white : (themeProvider.isDarkMode ? Colors.white : Colors.black),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleOption({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    required ThemeProvider themeProvider,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blue,
        ),
      ],
    );
  }

  Future<void> _logout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
        return AlertDialog(
          backgroundColor: themeProvider.isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          title: Text(
            '¿Cerrar sesión?',
            style: GoogleFonts.poppins(
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          content: Text(
            '¿Estás seguro de que quieres cerrar sesión?',
            style: GoogleFonts.poppins(
              color: themeProvider.isDarkMode ? Colors.white70 : Colors.black87,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(
                'Cancelar',
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(
                'Cerrar sesión',
                style: GoogleFonts.poppins(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true && mounted) {
      try {
        await AuthService().signOut();
        if (mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al cerrar sesión: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, ThemeProvider>(
      builder: (context, userProvider, themeProvider, _) {
        if (userProvider.isLoading && userProvider.user == null) {
          return Scaffold(
            backgroundColor: themeProvider.isDarkMode ? const Color(0xFF121212) : Colors.white,
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          backgroundColor: themeProvider.isDarkMode ? const Color(0xFF121212) : Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Mi Perfil',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                ),
                onPressed: _showPreferences,
              ),
              IconButton(
                icon: Icon(
                  _isEditing ? Icons.close : Icons.edit,
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    if (_isEditing) {
                      _updateControllers();
                    }
                    _isEditing = !_isEditing;
                  });
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade400,
                              Colors.purple.shade400,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: _profileImage != null
                            ? ClipOval(
                                child: Image.file(
                                  _profileImage!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Center(
                                child: Text(
                                  (userProvider.user?.fullName?.isNotEmpty ?? false) 
                                      ? userProvider.user!.fullName!.substring(0, 1).toUpperCase() 
                                      : 'U',
                                  style: GoogleFonts.poppins(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      ),
                      if (_isEditing)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: _pickImage,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.5),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ).animate().scale(duration: 600.ms, curve: Curves.easeOut),
                  const SizedBox(height: 30),
                  _buildTextField(
                    controller: _nameController,
                    label: 'Nombre completo',
                    icon: Icons.person,
                    enabled: _isEditing,
                    themeProvider: themeProvider,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _emailController,
                    label: 'Correo electrónico',
                    icon: Icons.email,
                    enabled: false,
                    themeProvider: themeProvider,
                    suffix: const Icon(Icons.lock, size: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _bioController,
                    label: 'Biografía',
                    icon: Icons.info_outline,
                    enabled: _isEditing,
                    maxLines: 3,
                    themeProvider: themeProvider,
                  ),
                  const SizedBox(height: 30),
                  if (_isEditing)
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'Guardar Cambios',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ).animate().fadeIn(duration: 300.ms),
                    ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.logout, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            'Cerrar Sesión',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool enabled,
    required ThemeProvider themeProvider,
    int maxLines = 1,
    Widget? suffix,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
        color: themeProvider.isDarkMode ? Colors.white : Colors.black,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(
          color: themeProvider.isDarkMode ? Colors.white70 : Colors.black54,
        ),
        prefixIcon: Icon(
          icon,
          color: themeProvider.isDarkMode ? Colors.white70 : Colors.black54,
        ),
        suffixIcon: suffix,
        filled: true,
        fillColor: themeProvider.isDarkMode 
            ? Colors.grey.withOpacity(0.1) 
            : Colors.grey.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.1),
          ),
        ),
      ),
      validator: (value) {
        if (enabled && (value == null || value.isEmpty)) {
          return 'Este campo es requerido';
        }
        return null;
      },
    );
  }
}