import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sekolah_kita/core/utils/navigate/navigate.dart';
import 'package:sekolah_kita/features/auth/views/pages/login_page.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Lottie.asset(
                'assets/animations/email_sent.json',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.mark_email_read_rounded,
                    size: 120,
                    color: color.primary,
                  );
                },
              ),
              const SizedBox(height: 32),

              // Title
              Text(
                'Verifikasi Email',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: color.onSurface,
                  height: 1.286,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Description
              Text(
                'Link verifikasi telah dikirim ke email Anda',
                style: TextStyle(
                  fontSize: 16,
                  color: color.onSurfaceVariant,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Info Text
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.primaryContainer.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: color.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: color.primary, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Silakan cek inbox atau folder spam Anda',
                        style: TextStyle(
                          fontSize: 12,
                          color: color.onSurfaceVariant,
                          height: 1.333,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Back to Login Button
              FilledButton.icon(
                onPressed: () {
                  Navigate.pushAndRemoveUntil(context, LoginPage());
                },
                icon: const Icon(Icons.login),
                label: const Text('Kembali ke Login'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
