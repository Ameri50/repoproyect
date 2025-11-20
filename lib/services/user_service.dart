import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';

class UserService {
  final SupabaseClient _client = Supabase.instance.client;
  final String _bucketName = 'avatars';

  // Obtener perfil de usuario
  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) throw Exception('No authenticated user');

      final response = await _client
          .from('users')
          .select()
          .eq('id', userId)
          .single();

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Actualizar perfil
  Future<void> updateProfile(Map<String, dynamic> updates) async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) throw Exception('No authenticated user');

      await _client.from('users').update(updates).eq('id', userId);
    } catch (e) {
      rethrow;
    }
  }

  // Subir avatar
  Future<String> uploadAvatar(File imageFile) async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) throw Exception('No authenticated user');

      final fileName = '$userId-${DateTime.now().millisecondsSinceEpoch}';
      
      await _client.storage.from(_bucketName).upload(
        fileName,
        imageFile,
        fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
      );

      final publicUrl = _client.storage
          .from(_bucketName)
          .getPublicUrl(fileName);

      // Actualiza la URL del avatar en la BD
      await updateProfile({'avatar_url': publicUrl});

      return publicUrl;
    } catch (e) {
      rethrow;
    }
  }

  // Actualizar tema
  Future<void> setTheme(bool isDarkMode) async {
    try {
      await updateProfile({
        'theme_mode': isDarkMode ? 'dark' : 'light',
      });
    } catch (e) {
      rethrow;
    }
  }

  // Actualizar idioma
  Future<void> setLanguage(String language) async {
    try {
      await updateProfile({'language': language});
    } catch (e) {
      rethrow;
    }
  }
}