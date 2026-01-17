import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sekolah_kita/core/database/local_data_persisance.dart';
import 'package:sekolah_kita/features/profile/models/profile_model.dart';
import 'package:sekolah_kita/features/profile/services/local_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState.initial()) {
    on<CreateProfile>(_handleCreateProfile);
    on<GetProfile>(_handleGetProfile);
  }

  Future<void> _handleCreateProfile(
    CreateProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileState(status: ProfileStateStatus.loading));

    try {
      LocalDataPersisance()
        ..setAvatar(event.avatar)
        ..setUsername(event.username);

      emit(ProfileState(status: ProfileStateStatus.success));
    } catch (e) {
      if (kDebugMode) print(e);
      emit(ProfileState(status: ProfileStateStatus.failure));
    } finally {
      emit(ProfileState(status: ProfileStateStatus.initial));
    }
  }

  Future<void> _handleGetProfile(
    GetProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileState(status: ProfileStateStatus.loading));
    try {
      final localData = LocalDataPersisance();
      final profile = ProfileModel(
        username: localData.getUsername ?? '----',
        avatar: localData.getAvatar ?? '',
        kelas: 'Kelas 4 SD',
        bintang: await LocalService().getStars(),
        waktuBelajar: _parseSecond(localData.getTotalSeconds ?? 0),
        modul: LocalService().getTotalModule(),
      );

      emit(ProfileState(status: ProfileStateStatus.success, profile: profile));
    } catch (e) {
      if (kDebugMode) print(e);
      emit(ProfileState(status: ProfileStateStatus.failure));
    }
  }

  String _parseSecond(int seconds) {
    if (seconds <= 60) {
      return '$seconds detik';
    }

    if (seconds <= 3600) {
      final minutes = (seconds / 60).floor();
      return '$minutes menit';
    }

    final hours = (seconds / 3600).floor();
    return '$hours jam';
  }
}
