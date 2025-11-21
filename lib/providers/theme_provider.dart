import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = true;
  String _selectedLanguage = 'es';
  ThemeMode _themeMode = ThemeMode.dark;
  bool _isAdaptiveMode = false;
  late SharedPreferences _prefs;
  bool _isInitialized = false;

  ThemeProvider() {
    _initializePreferences();
  }

  // Getters
  bool get isDarkMode => _isDarkMode;
  String get selectedLanguage => _selectedLanguage;
  bool get isInitialized => _isInitialized;
  ThemeMode get themeMode => _themeMode;
  bool get isAdaptiveMode => _isAdaptiveMode;

  ThemeData get themeData {
    if (_isDarkMode) {
      return ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF06b6d4),
        scaffoldBackgroundColor: const Color(0xFF0a0e27),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0a0e27),
          elevation: 0,
          centerTitle: true,
        ),
      );
    } else {
      return ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF06b6d4),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
      );
    }
  }

  get language => null;

  // Inicializar SharedPreferences
  Future<void> _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _isDarkMode = _prefs.getBool('isDarkMode') ?? true;
    _selectedLanguage = _prefs.getString('selectedLanguage') ?? 'es';
    _isAdaptiveMode = _prefs.getBool('isAdaptiveMode') ?? false;
    _isInitialized = true;
    notifyListeners();
  }

  // Cambiar tema (oscuro/claro)
  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  // Cambiar idioma (español/inglés)
  Future<void> toggleLanguage() async {
    _selectedLanguage = _selectedLanguage == 'es' ? 'en' : 'es';
    await _prefs.setString('selectedLanguage', _selectedLanguage);
    notifyListeners();
  }

  // Establecer tema específico
  Future<void> setDarkMode(bool isDark) async {
    _isDarkMode = isDark;
    await _prefs.setBool('isDarkMode', isDark);
    notifyListeners();
  }

  // Establecer idioma específico
  Future<void> setLanguage(String language) async {
    if (language == 'es' || language == 'en') {
      _selectedLanguage = language;
      await _prefs.setString('selectedLanguage', language);
      notifyListeners();
    }
  }

  // Establecer modo de tema (Claro, Oscuro, Adaptativo)
  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    _isAdaptiveMode = false;
    
    if (mode == ThemeMode.dark) {
      _isDarkMode = true;
    } else if (mode == ThemeMode.light) {
      _isDarkMode = false;
    }
    
    await _prefs.setBool('isDarkMode', _isDarkMode);
    await _prefs.setBool('isAdaptiveMode', false);
    notifyListeners();
  }

  // Establecer modo adaptativo
  Future<void> setAdaptiveMode(bool isAdaptive) async {
    _isAdaptiveMode = isAdaptive;
    await _prefs.setBool('isAdaptiveMode', isAdaptive);
    if (isAdaptive) {
      _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }
}