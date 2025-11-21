import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  // Registro
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      debugPrint('===== SIGN UP =====');
      debugPrint('Email: $email');
      debugPrint('Name: $fullName');

      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName},
      );

      if (response.user != null) {
        debugPrint('User created: ${response.user!.id}');
        debugPrint('✅ Usuario autenticado en Supabase Auth');

        // Insertar en la tabla usuarios
        try {
          await _client.from('usuarios').insert({
            'id': response.user!.id,
            'email': email,
            'full_name': fullName,
            'created_at': DateTime.now().toIso8601String(),
          });
          debugPrint('✅ Usuario registrado en BD');
        } catch (dbError) {
          debugPrint('⚠️ Error al insertar en BD: $dbError');
          // El usuario ya está en Auth, así que continuamos
        }
      }

      return response;
    } on AuthException catch (e) {
      debugPrint('❌ Auth error: ${e.message}');
      throw Exception('Error de registro: ${e.message}');
    } catch (e) {
      debugPrint('❌ Sign up error: $e');
      throw Exception('Error de registro: $e');
    }
  }

  // Inicio de sesión
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      debugPrint('===== SIGN IN =====');
      debugPrint('Email: $email');

      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      debugPrint('✅ Login exitoso: ${response.user!.id}');
      return response;
    } on AuthException catch (e) {
      debugPrint('❌ Auth error: ${e.message}');
      throw Exception('Error de login: ${e.message}');
    } catch (e) {
      debugPrint('❌ Sign in error: $e');
      throw Exception('Error de login: $e');
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    try {
      debugPrint('===== SIGN OUT =====');
      await _client.auth.signOut();
      debugPrint('✅ Sesión cerrada');
    } on AuthException catch (e) {
      debugPrint('❌ Auth error: ${e.message}');
      throw Exception('Error al cerrar sesión: ${e.message}');
    } catch (e) {
      debugPrint('❌ Sign out error: $e');
      throw Exception('Error al cerrar sesión: $e');
    }
  }

  // Obtener usuario actual
  User? getCurrentUser() {
    return _client.auth.currentUser;
  }

  // Obtener ID del usuario actual
  String? getCurrentUserId() {
    return _client.auth.currentUser?.id;
  }

  // Verificar si está autenticado
  bool isAuthenticated() {
    return _client.auth.currentSession != null;
  }

  // Stream de cambios de autenticación
  Stream<AuthState> get authStateChanges {
    return _client.auth.onAuthStateChange;
  }

  // Recuperar contraseña
  Future<void> resetPassword(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      debugPrint('❌ Auth error: ${e.message}');
      throw Exception('Error al recuperar contraseña: ${e.message}');
    } catch (e) {
      debugPrint('❌ Password reset error: $e');
      throw Exception('Error al recuperar contraseña: $e');
    }
  }
}