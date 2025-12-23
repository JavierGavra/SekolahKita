import 'package:flutter/material.dart';

class GreetingCard extends StatelessWidget {
  const GreetingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
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
            "🎯",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 48, height: 1),
          ),
          const SizedBox(height: 12),
          Text(
            'Terus Semangat!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Kamu sudah menyelesaikan 12 modul bulan ini. Pertahankan konsistensimu!',
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
