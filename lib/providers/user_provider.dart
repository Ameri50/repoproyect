import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  AppUser? _currentUser;
  bool _isLoading = false;
  String? _error;

  AppUser? get user => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _currentUser != null;

  final _supabase = Supabase.instance.client;

  // Cargar perfil del usuario desde Supabase
  Future<void> fetchUserProfile() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final userId = _supabase.auth.currentUser?.id;
      
      if (userId == null) {
        throw Exception('No hay usuario autenticado');
      }

      debugPrint('===== FETCH USER PROFILE =====');
      debugPrint('User ID: $userId');

      final response = await _supabase
          .from('usuarios')
          .select()
          .eq('id', userId)
          .maybeSingle();

      debugPrint('Response: $response');

      if (response != null) {
        _currentUser = AppUser.fromJson(response);
        debugPrint('✅ Usuario cargado: ${_currentUser?.fullName}');
      } else {
        // Si no existe en la tabla, crear registro básico
        final authUser = _supabase.auth.currentUser;
        
        // Crear en la base de datos
        await _supabase.from('usuarios').insert({
          'id': userId,
          'email': authUser?.email ?? '',
          'full_name': authUser?.userMetadata?['full_name'] ?? 'Usuario',
          'created_at': DateTime.now().toIso8601String(),
        });
        
        _currentUser = AppUser(
          id: userId,
          email: authUser?.email ?? '',
          fullName: authUser?.userMetadata?['full_name'] ?? 'Usuario',
          createdAt: DateTime.now(),
        );
        debugPrint('✅ Usuario creado en BD');
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('❌ Error al cargar perfil: $e');
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Actualizar perfil del usuario en Supabase
  Future<void> updateUserProfile(Map<String, dynamic> updates) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final userId = _supabase.auth.currentUser?.id;
      
      if (userId == null) {
        throw Exception('No hay usuario autenticado');
      }

      debugPrint('===== UPDATE USER PROFILE =====');
      debugPrint('User ID: $userId');
      debugPrint('Updates: $updates');

      // Actualizar en Supabase
      await _supabase
          .from('usuarios')
          .upsert({
            'id': userId,
            ...updates,
            'updated_at': DateTime.now().toIso8601String(),
          });

      debugPrint('✅ Perfil actualizado en Supabase');

      // Actualizar localmente
      if (_currentUser != null) {
        _currentUser = _currentUser!.copyWith(
          fullName: updates['full_name'] ?? _currentUser!.fullName,
          bio: updates['bio'] ?? _currentUser!.bio,
          avatarUrl: updates['avatar_url'] ?? _currentUser!.avatarUrl,
        );
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('❌ Error al actualizar perfil: $e');
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Establecer usuario (útil después del login)
  void setUser(AppUser user) {
    _currentUser = user;
    notifyListeners();
  }

  // Limpiar usuario (útil en logout)
  void clearUser() {
    _currentUser = null;
    _error = null;
    _isLoading = false;
    notifyListeners();
  }

  // Subir avatar a Supabase Storage
  Future<String?> uploadAvatar(String filePath) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('No hay usuario autenticado');

      final fileName = '$userId-${DateTime.now().millisecondsSinceEpoch}.jpg';
      
      await _supabase.storage
          .from('avatars')
          .upload(fileName, filePath as File);

      final avatarUrl = _supabase.storage
          .from('avatars')
          .getPublicUrl(fileName);

      debugPrint('✅ Avatar subido: $avatarUrl');
      return avatarUrl;
    } catch (e) {
      debugPrint('❌ Error al subir avatar: $e');
      return null;
    }
  }
}