import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:sekolah_kita/core/constant/constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GoogleService {
  Future<AuthResponse> googleSignIn() async {
    try {
      final GoogleSignIn signIn = GoogleSignIn.instance;

      // 1️⃣ WAJIB await initialize
      await signIn.initialize(
        clientId: iosClientId,
        serverClientId: webClientId, // web client ID dari Google Console
      );

      // 2️⃣ Authenticate user
      final googleAccount = await signIn.authenticate();

      // 3️⃣ Ambil authentication (WAJIB await)
      final googleAuth = googleAccount.authentication;

      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw Exception('Google ID Token is null');
      }

      // 4️⃣ Kirim ke Supabase
      return Supabase.instance.client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
      );
    } catch (e) {
      throw _handleAuthError(e as AuthException);
    }
  }

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
}
