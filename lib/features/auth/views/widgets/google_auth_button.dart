import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sekolah_kita/core/constant/svg_assets.dart';
import 'package:sekolah_kita/features/auth/bloc/auth_bloc.dart';

class GoogleAuthButton extends StatelessWidget {
  final bool isLogin;

  const GoogleAuthButton.login({super.key}) : isLogin = true;

  const GoogleAuthButton.register({super.key}) : isLogin = false;

  void _onLogin(BuildContext context) {
    context.read<AuthBloc>().add(const GoogleLoginRequested());
  }

  void _onRegister(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => isLogin ? _onLogin(context) : _onRegister(context),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          side: BorderSide(color: color.onSurfaceVariant),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(SvgAssets.googleIcon, width: 20, height: 20),
            const SizedBox(width: 12),
            Text(
              "${isLogin ? "Masuk" : "Daftar"} dengan Google",
              style: TextStyle(height: 1.428, color: color.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
