import 'package:flutter/material.dart';
import 'dart:async';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  String _selectedLanguage = 'es';
  bool _isAdaptiveMode = false;
  Timer? _adaptiveTimer;

  bool get isDarkMode => _isDarkMode;
  String get selectedLanguage => _selectedLanguage;
  bool get isAdaptiveMode => _isAdaptiveMode;

  ThemeProvider() {
    _initializeAdaptiveMode();
  }

  void _initializeAdaptiveMode() {
    if (_isAdaptiveMode) {
      _checkTimeAndUpdateTheme();
      // Actualizar cada minuto
      _adaptiveTimer = Timer.periodic(const Duration(minutes: 1), (_) {
        _checkTimeAndUpdateTheme();
      });
    }
  }

  void _checkTimeAndUpdateTheme() {
    final hour = DateTime.now().hour;
    
    // Considera noche de 19:00 (7 PM) a 06:00 (6 AM)
    // Considera día de 06:00 a 19:00
    final isNight = hour >= 19 || hour < 6;
    
    _isDarkMode = isNight;
    notifyListeners();
  }

  void _cancelAdaptiveTimer() {
    if (_adaptiveTimer != null && _adaptiveTimer!.isActive) {
      _adaptiveTimer!.cancel();
      _adaptiveTimer = null;
    }
  }

  void toggleTheme() {
    _isAdaptiveMode = false;
    _cancelAdaptiveTimer();
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _isAdaptiveMode = false;
    _cancelAdaptiveTimer();
    
    if (mode == ThemeMode.light) {
      _isDarkMode = false;
    } else if (mode == ThemeMode.dark) {
      _isDarkMode = true;
    }
    notifyListeners();
  }

  void setAdaptiveMode(bool isAdaptive) {
    _isAdaptiveMode = isAdaptive;
    
    if (isAdaptive) {
      _checkTimeAndUpdateTheme();
      _adaptiveTimer = Timer.periodic(const Duration(minutes: 1), (_) {
        _checkTimeAndUpdateTheme();
      });
    } else {
      _cancelAdaptiveTimer();
    }
    notifyListeners();
  }

  void setLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }

  // ThemeData para modo claro
  ThemeData get _lightTheme {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF5F7FA),
        elevation: 0,
      ),
      primaryColor: const Color(0xFF8b5cf6),
      useMaterial3: true,
    );
  }

  // ThemeData para modo oscuro
  ThemeData get _darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF0f1419),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0f1419),
        elevation: 0,
      ),
      primaryColor: const Color(0xFF8b5cf6),
      useMaterial3: true,
    );
  }

  // ThemeData general (retorna el tema correcto según isDarkMode)
  ThemeData get themeData {
    return _isDarkMode ? _darkTheme : _lightTheme;
  }

  @override
  void dispose() {
    _cancelAdaptiveTimer();
    super.dispose();
  }
}