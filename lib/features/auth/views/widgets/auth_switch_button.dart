import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sekolah_kita/features/auth/views/pages/login_page.dart';
import 'package:sekolah_kita/features/auth/views/pages/register_page.dart';

class AuthSwitchButton extends StatelessWidget {
  final bool isToRegister;

  const AuthSwitchButton.toRegister({super.key}) : isToRegister = true;

  const AuthSwitchButton.isToLogin({super.key}) : isToRegister = false;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Center(
      child: TextButton(
        onPressed: () => context.pushReplacementTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          childBuilder: (context) =>
              isToRegister ? RegisterPage() : LoginPage(),
        ),
        child: Text.rich(
          TextSpan(
            text: "${isToRegister ? 'Belum' : 'Sudah'} punya akun? ",
            style: TextStyle(
              fontSize: 14,
              height: 1.4286,
              color: color.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            children: [
              TextSpan(
                text: isToRegister ? "Daftar" : "Masuk",
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4286,
                  color: color.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
