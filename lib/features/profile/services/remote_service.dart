import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Get user profile from database
  Future<Map<String, dynamic>?> getUserProfile({required String userId}) async {
    try {
      final response = await _supabase
          .from('profil')
          .select()
          .eq('id', userId)
          .maybeSingle();

      return response;
    } catch (e) {
      throw Exception('Gagal mengambil profil: $e');
    }
  }
}
