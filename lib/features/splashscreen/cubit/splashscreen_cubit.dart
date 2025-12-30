import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sekolah_kita/core/constant/constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sekolah_kita/core/database/database_helper.dart';
import 'package:sekolah_kita/core/database/local_data_persisance.dart';

part 'splashscreen_state.dart';

class SplashscreenCubit extends Cubit<SplashscreenState> {
  SplashscreenCubit() : super(SplashscreenState.initial());

  Future<void> init() async {
    try {
      emit(SplashscreenState(status: SplashscreenStatus.loading));

      await Future.delayed(const Duration(milliseconds: 700));

      // Local Database (SQFlite)
      await DatabaseHelper.instance.database;

      // Local Data Persisance (Shared Preferences)
      await LocalDataPersisance.init();

      // Supabase Initialization
      await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

      emit(SplashscreenState(status: SplashscreenStatus.success));
    } catch (e) {
      emit(
        SplashscreenState(
          status: SplashscreenStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
