import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_kita/core/utils/navigate/navigate.dart';
import 'package:sekolah_kita/features/auth/bloc/auth_bloc.dart';
import 'package:sekolah_kita/features/auth/views/pages/login_page.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStateStatus.unauthenticated) {
          Navigator.of(context).pop(false);
          Navigate.pushAndRemoveUntil(context, const LoginPage());
        }
      },
      child: AlertDialog(
        title: const Text('Logout'),
        content: const Text('Apakah anda yakin?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
            },
            style: FilledButton.styleFrom(backgroundColor: color.error),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
