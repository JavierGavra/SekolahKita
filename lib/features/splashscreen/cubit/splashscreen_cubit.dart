import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/database_helper.dart';
import 'package:sekolah_kita/core/database/local_data_persisance.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:sekolah_kita/core/constant/constant.dart';

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
      if (LocalDataPersisance().getIsFirstOpen ?? true) {
        LocalDataPersisance()
          ..setLastModuleIndex(CourseType.reading, 1)
          ..setLastModuleIndex(CourseType.writing, 2)
          ..setLastModuleIndex(CourseType.numeration, 1);
      }

      // Supabase Initialization
      // await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

      emit(SplashscreenState(status: SplashscreenStatus.success));
    } catch (e) {
      if (kDebugMode) print(e);
      emit(
        SplashscreenState(
          status: SplashscreenStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
