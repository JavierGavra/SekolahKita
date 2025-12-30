import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<AuthResponse> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'name': name, 'display_name': name},
      );

      if (response.user == null) {
        throw 'Registrasi gagal. Silakan coba lagi.';
      }

      return response;
    } on AuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      throw 'Terjadi kesalahan: $e';
    }
  }

  /// Login with email and password
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw 'Login gagal. Email atau password salah.';
      }

      return response;
    } on AuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      throw 'Terjadi kesalahan: $e';
    }
  }

  /// Logout current user
  Future<void> logout() async {
    try {
      await _supabase.auth.signOut();
    } on AuthException catch (e) {
      throw _handleAuthError(e);
    } catch (e) {
      throw 'Gagal logout: $e';
    }
  }

  /// Get current user
  User? getCurrentUser() {
    return _supabase.auth.currentUser;
  }

  /// Get current session
  Session? getCurrentSession() {
    return _supabase.auth.currentSession;
  }

  /// Check if user is logged in
  bool isLoggedIn() {
    return _supabase.auth.currentUser != null;
  }

  /// Get access token
  String? getAccessToken() {
    return _supabase.auth.currentSession?.accessToken;
  }

  /// Reset password - Send reset email
  Future<void> resetPassword({required String email}) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw Exception(_handleAuthError(e));
    } catch (e) {
      throw Exception('Gagal mengirim email reset: $e');
    }
  }

  /// Update user password
  Future<UserResponse> updatePassword({required String newPassword}) async {
    try {
      final response = await _supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );

      if (response.user == null) {
        throw Exception('Gagal mengubah password');
      }

      return response;
    } on AuthException catch (e) {
      throw Exception(_handleAuthError(e));
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  /// Update user profile
  Future<UserResponse> updateProfile({
    String? name,
    String? photoUrl,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      final data = <String, dynamic>{};

      if (name != null) {
        data['name'] = name;
        data['display_name'] = name;
      }

      if (photoUrl != null) {
        data['photo_url'] = photoUrl;
        data['avatar_url'] = photoUrl;
      }

      if (additionalData != null) {
        data.addAll(additionalData);
      }

      final response = await _supabase.auth.updateUser(
        UserAttributes(data: data),
      );

      if (response.user == null) {
        throw Exception('Gagal mengubah profil');
      }

      return response;
    } on AuthException catch (e) {
      throw Exception(_handleAuthError(e));
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  /// Listen to auth state changes
  Stream<AuthState> onAuthStateChange() {
    return _supabase.auth.onAuthStateChange;
  }

  // ============================================================
  // HELPER METHODS
  // ============================================================

  /// Handle Supabase Auth errors
  String _handleAuthError(AuthException error) {
    switch (error.statusCode) {
      case '400':
        return 'Email atau password tidak valid';
      case '401':
        return 'Email atau password salah';
      case '422':
        if (error.message.contains('already registered')) {
          return 'Email sudah terdaftar';
        }
        return 'Data tidak valid';
      case '429':
        return 'Terlalu banyak percobaan. Silakan coba lagi nanti';
      default:
        return error.message;
    }
  }

  // ============================================================
  // DATABASE OPERATIONS (Optional)
  // ============================================================

  /// Create user profile in database after registration
  Future<void> createUserProfile({
    required String userId,
    required String namaLengkap,
  }) async {
    try {
      await _supabase.from('profil').insert({
        'id': userId,
        'nama_lengkap': namaLengkap,
      });
    } catch (e) {
      throw Exception('Gagal membuat profil: $e');
    }
  }

  /// Get user profile from database
  Future<Map<String, dynamic>?> getUserProfile({required String userId}) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      return response;
    } catch (e) {
      throw Exception('Gagal mengambil profil: $e');
    }
  }

  /// Update user profile in database
  Future<void> updateUserProfile({
    required String userId,
    Map<String, dynamic>? data,
  }) async {
    try {
      if (data != null && data.isNotEmpty) {
        await _supabase.from('profiles').update(data).eq('id', userId);
      }
    } catch (e) {
      throw Exception('Gagal mengupdate profil: $e');
    }
  }

  /// Delete user profile (soft delete)
  Future<void> deleteUserProfile({required String userId}) async {
    try {
      await _supabase
          .from('profiles')
          .update({'deleted_at': DateTime.now().toIso8601String()})
          .eq('id', userId);
    } catch (e) {
      throw Exception('Gagal menghapus profil: $e');
    }
  }
}
