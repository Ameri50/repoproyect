import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  // Registro
  Future<AuthResponse> signUp(String email, String password, String fullName) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName},
      );

      if (response.user != null) {
        // Crea registro en tabla users
        await _client.from('users').insert({
          'id': response.user!.id,
          'email': email,
          'full_name': fullName,
        });
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Inicio de sesión
  Future<AuthResponse> signIn(String email, String password) async {
    try {
      return await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  // Obtener usuario actual
  User? getCurrentUser() {
    return _client.auth.currentUser;
  }

  // Verificar si está autenticado
  bool isAuthenticated() {
    return _client.auth.currentSession != null;
  }
}