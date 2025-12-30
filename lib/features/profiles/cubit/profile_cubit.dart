import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sekolah_kita/core/database/local_data_persisance.dart';
import 'package:sekolah_kita/core/utils/network/network_utils.dart';
import 'package:sekolah_kita/features/profiles/models/profile_model.dart';
import 'package:sekolah_kita/features/profiles/services/remote_service.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState.initial());

  final _remote = RemoteService();

  Future<void> loadProfile() async {
    emit(state.copyWith(status: ProfileStateStatus.loading));
    ProfileModel? profile;

    try {
      // Simulate a network call or data fetching
      final isOnline = await NetworkUtils.isOnline();
      if (!isOnline) throw SocketException('');

      final response = await _remote.getUserProfile(
        userId: LocalDataPersisance().getUserId!,
      );

      profile = ProfileModel(
        nama: response?['nama_lengkap'] ?? '----',
        kelas: 'Kelas 4 SD',
        bintang: 10,
        jamBelajar: 30,
        modul: 15,
      );
    } catch (e) {
      if (kDebugMode) print("$e");
      final data = LocalDataPersisance();
      profile = ProfileModel(
        nama: data.getUsername ?? '----',
        kelas: 'Kelas 4 SD',
        bintang: 10,
        jamBelajar: 30,
        modul: 15,
      );
    } finally {
      emit(
        state.copyWith(status: ProfileStateStatus.success, profile: profile),
      );
    }
  }
}
