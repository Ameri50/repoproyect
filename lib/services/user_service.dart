import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';

class UserService {
  final SupabaseClient _client = Supabase.instance.client;
  final String _bucketName = 'avatars';

  // Obtener perfil de usuario
  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final userId = _client.auth.currentUser?.id;
      debugPrint('===== GET USER PROFILE =====');
      debugPrint('User ID: $userId');
      
      if (userId == null) {
        throw Exception('No authenticated user');
      }

      final response = await _client
          .from('usuarios')
          .select()
          .eq('id', userId)
          .single();

      debugPrint('✅ Perfil obtenido: $response');
      return response;
    } on PostgrestException catch (e) {
      debugPrint('❌ Database error: ${e.message}');
      throw Exception('Database error: ${e.message}');
    } catch (e) {
      debugPrint('❌ Get profile error: $e');
      throw Exception('Get profile error: $e');
    }
  }

  // Actualizar perfil
  Future<void> updateProfile(Map<String, dynamic> updates) async {
    try {
      final userId = _client.auth.currentUser?.id;
      debugPrint('===== UPDATE PROFILE =====');
      debugPrint('User ID: $userId');
      debugPrint('Updates: $updates');
      
      if (userId == null) {
        throw Exception('No authenticated user');
      }

      // Añade fecha de actualización
      updates['updated_at'] = DateTime.now().toIso8601String();
      
      debugPrint('Enviando a Supabase...');
      
      final response = await _client
          .from('usuarios')
          .update(updates)
          .eq('id', userId);

      debugPrint('✅ Perfil actualizado exitosamente');
      debugPrint('Response: $response');
    } on PostgrestException catch (e) {
      debugPrint('❌ Database error: ${e.message}');
      debugPrint('❌ Error code: ${e.code}');
      throw Exception('Database error: ${e.message}');
    } catch (e) {
      debugPrint('❌ Update profile error: $e');
      throw Exception('Update profile error: $e');
    }
  }

  // Subir avatar
  Future<String> uploadAvatar(File imageFile) async {
    try {
      final userId = _client.auth.currentUser?.id;
      debugPrint('===== UPLOAD AVATAR =====');
      debugPrint('User ID: $userId');
      
      if (userId == null) {
        throw Exception('No authenticated user');
      }

      final fileName = '$userId-${DateTime.now().millisecondsSinceEpoch}.jpg';
      
      // Elimina avatar anterior si existe
      try {
        await _client.storage.from(_bucketName).remove(['$userId.jpg']);
      } catch (e) {
        debugPrint('No previous avatar found');
      }

      // Sube nuevo avatar
      await _client.storage.from(_bucketName).upload(
        fileName,
        imageFile,
        fileOptions: const FileOptions(
          cacheControl: '3600',
          upsert: true,
        ),
      );

      // Obtiene URL pública
      final publicUrl = _client.storage
          .from(_bucketName)
          .getPublicUrl(fileName);

      debugPrint('✅ Avatar URL: $publicUrl');

      // Actualiza la URL del avatar en la BD
      await updateProfile({'avatar_url': publicUrl});

      return publicUrl;
    } catch (e) {
      debugPrint('❌ Upload avatar error: $e');
      throw Exception('Upload avatar error: $e');
    }
  }

  // Actualizar tema
  Future<void> setTheme(bool isDarkMode) async {
    try {
      await updateProfile({
        'theme_mode': isDarkMode ? 'dark' : 'light',
      });
    } catch (e) {
      debugPrint('❌ Set theme error: $e');
      throw Exception('Set theme error: $e');
    }
  }

  // Actualizar idioma
  Future<void> setLanguage(String language) async {
    try {
      if (language != 'es' && language != 'en') {
        throw Exception('Invalid language: $language');
      }
      
      await updateProfile({'language': language});
    } catch (e) {
      debugPrint('❌ Set language error: $e');
      throw Exception('Set language error: $e');
    }
  }

  // Obtener lista de mentores
  Future<List<Map<String, dynamic>>> getMentors() async {
    try {
      debugPrint('===== GET MENTORS =====');
      
      final response = await _client
          .from('mentores')
          .select()
          .eq('is_active', true);

      debugPrint('✅ Mentores obtenidos: ${response.length}');
      return List<Map<String, dynamic>>.from(response);
    } on PostgrestException catch (e) {
      debugPrint('❌ Database error: ${e.message}');
      throw Exception('Database error: ${e.message}');
    } catch (e) {
      debugPrint('❌ Get mentors error: $e');
      throw Exception('Get mentors error: $e');
    }
  }

  // Obtener notificaciones del usuario
  Future<List<Map<String, dynamic>>> getUserNotifications() async {
    try {
      final userId = _client.auth.currentUser?.id;
      debugPrint('===== GET NOTIFICATIONS =====');
      debugPrint('User ID: $userId');
      
      if (userId == null) throw Exception('No authenticated user');

      final response = await _client
          .from('notificaciones')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false)
          .limit(20);

      debugPrint('✅ Notificaciones obtenidas: ${response.length}');
      return List<Map<String, dynamic>>.from(response);
    } on PostgrestException catch (e) {
      debugPrint('❌ Database error: ${e.message}');
      throw Exception('Database error: ${e.message}');
    } catch (e) {
      debugPrint('❌ Get notifications error: $e');
      throw Exception('Get notifications error: $e');
    }
  }

  // Marcar notificación como leída
  Future<void> markNotificationAsRead(String notificationId) async {
    try {
      await _client
          .from('notificaciones')
          .update({'is_read': true})
          .eq('id', notificationId);
    } catch (e) {
      debugPrint('❌ Mark notification error: $e');
      throw Exception('Mark notification error: $e');
    }
  }

  // Eliminar cuenta
  Future<void> deleteAccount() async {
    try {
      final userId = _client.auth.currentUser?.id;
      debugPrint('===== DELETE ACCOUNT =====');
      debugPrint('User ID: $userId');
      
      if (userId == null) throw Exception('No authenticated user');

      // Elimina datos de usuario
      await _client.from('usuarios').delete().eq('id', userId);
      
      debugPrint('✅ Cuenta eliminada');
    } catch (e) {
      debugPrint('❌ Delete account error: $e');
      throw Exception('Delete account error: $e');
    }
  }
}