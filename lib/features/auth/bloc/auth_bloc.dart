import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sekolah_kita/core/database/local_data_persisance.dart';
import 'package:sekolah_kita/features/auth/services/google_service.dart';
import 'package:sekolah_kita/features/auth/services/remote_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.initial()) {
    on<LoginRequested>(_onLoginRequested);
    on<GoogleLoginRequested>(_onGoogleLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<AuthStatusChecked>(_onAuthStatusChecked);
  }

  final RemoteService _remote = RemoteService();

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState(status: AuthStateStatus.loading));

    try {
      print(event.email);
      final response = await _remote.login(
        email: event.email,
        password: event.password,
      );

      LocalDataPersisance()
        ..setEmail(response.user!.email!)
        ..setUsername(response.user!.userMetadata!['name']);

      emit(AuthState(status: AuthStateStatus.authenticated));
    } catch (e) {
      if (kDebugMode) print(e.toString());
      emit(AuthState(status: AuthStateStatus.failure, errorMessage: "$e"));
    }
  }

  Future<void> _onGoogleLoginRequested(
    GoogleLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState(status: AuthStateStatus.loading));

    try {
      final response = await GoogleService().googleSignIn();

      LocalDataPersisance()
        ..setEmail(response.user!.email!)
        ..setUsername(response.user!.userMetadata!['name']);

      emit(AuthState(status: AuthStateStatus.authenticated));
    } catch (e) {
      if (kDebugMode) print(e.toString());
      emit(
        AuthState(
          status: AuthStateStatus.failure,
          errorMessage: 'Gagal login dengan Google',
        ),
      );
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState(status: AuthStateStatus.loading));

    try {
      final response = await _remote.register(
        email: event.email,
        password: event.password,
        name: event.name,
      );

      emit(AuthState(status: AuthStateStatus.authenticated));

      // Jika gagal:
      // emit(AuthState(
      //   status: AuthStateStatus.failure,
      //   errorMessage: 'Email sudah terdaftar',
      // ));
    } catch (e) {
      if (kDebugMode) print(e.toString());
      emit(
        AuthState(
          status: AuthStateStatus.failure,
          errorMessage: 'Terjadi kesalahan: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState(status: AuthStateStatus.loading));

    try {
      // TODO: Clear token/session
      // await _authRepository.logout();

      await Future.delayed(const Duration(milliseconds: 500));

      emit(const AuthState(status: AuthStateStatus.unauthenticated));
    } catch (e) {
      emit(
        AuthState(
          status: AuthStateStatus.failure,
          errorMessage: 'Gagal logout: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onAuthStatusChecked(
    AuthStatusChecked event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState(status: AuthStateStatus.loading));

    try {
      // TODO: Check if user is already logged in
      // Check token from local storage
      // final isLoggedIn = await _authRepository.isLoggedIn();

      await Future.delayed(const Duration(milliseconds: 500));

      // Simulasi cek token
      final bool isLoggedIn = false; // Replace dengan actual check

      if (isLoggedIn) {
        // TODO: Get user data from storage/API
        emit(AuthState(status: AuthStateStatus.authenticated));
      } else {
        emit(AuthState(status: AuthStateStatus.unauthenticated));
      }
    } catch (e) {
      emit(
        AuthState(
          status: AuthStateStatus.unauthenticated,
          errorMessage: 'Gagal memeriksa status: ${e.toString()}',
        ),
      );
    }
  }
}
