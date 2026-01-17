import 'package:flutter/material.dart';
import 'package:sekolah_kita/features/home/services/local_service.dart';

class GreetingCard extends StatelessWidget {
  const GreetingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    final totalModule = LocalService().getTotalModule();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.outlineVariant),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.primary.withValues(alpha: 0.1),
            color.secondary.withValues(alpha: 0.1),
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            (totalModule == 0) ? "🚀" : "🎯",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 48, height: 1),
          ),
          const SizedBox(height: 12),
          Text(
            (totalModule == 0) ? "Mulai Belajar" : 'Terus Semangat!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            (totalModule == 0)
                ? "Buktikan bahwa kamu anak yang cerdas!"
                : 'Kamu sudah menyelesaikan $totalModule modul. Pertahankan performamu!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color.onSurfaceVariant,
              fontSize: 14,
              height: 1.428,
            ),
          ),
        ],
      ),
    );
  }
}
