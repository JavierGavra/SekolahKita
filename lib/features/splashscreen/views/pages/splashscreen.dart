import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_kita/core/database/local_data_persisance.dart';
import 'package:sekolah_kita/core/utils/navigate/navigate.dart';
import 'package:sekolah_kita/core/widgets/custom_snackbar.dart';
import 'package:sekolah_kita/features/introduction/views/pages/introduction_page.dart';
import 'package:sekolah_kita/features/navigation/views/pages/bottom_navigation.dart';
import 'package:sekolah_kita/features/profile/views/pages/create_profile_page.dart';
import 'package:sekolah_kita/features/splashscreen/cubit/splashscreen_cubit.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  void _listener(BuildContext context, SplashscreenState state) {
    if (state.status == SplashscreenStatus.failure) {
      showSnackBar(context, SnackBarType.failed);
      return;
    }

    final isFirstOpen = LocalDataPersisance().getIsFirstOpen ?? true;
    final isLogin = LocalDataPersisance().getUsername != null;
    Navigate.pushReplacement(
      context,
      isFirstOpen
          ? const IntroductionPage()
          : isLogin
          ? const BottomNavigation()
          : const CreateProfilePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (context) => SplashscreenCubit()..init(),
      child: Scaffold(
        body: BlocListener<SplashscreenCubit, SplashscreenState>(
          listener: _listener,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [color.primary, Color(0xFF0F4A5F)],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 128,
                  width: 128,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.surfaceContainerLowest.withValues(alpha: 0.2),
                  ),
                  child: Icon(
                    Icons.school_outlined,
                    size: 64,
                    color: color.onPrimary,
                  ),
                ),
                SizedBox(height: 46),
                Text(
                  "SekolahKita",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.1875,
                    color: color.onPrimary,
                  ),
                ),
                SizedBox(height: 17),
                Text(
                  "Belajar Bersama, Tumbuh Bersama",
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: color.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
