import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
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
          _buildTitle(color),
          const SizedBox(height: 16),
          _buildInfoItem(
            color,
            '1',
            'Selesaikan modul sebelumnya untuk membuka modul berikutnya',
          ),
          const SizedBox(height: 12),
          _buildInfoItem(
            color,
            '2',
            'Dapatkan bintang dengan menyelesaikan kuis dengan nilai 80% atau lebih',
          ),
          const SizedBox(height: 12),
          _buildInfoItem(
            color,
            '3',
            'Semua materi dapat diakses secara offline',
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(ColorScheme color) {
    return Row(
      spacing: 8,
      children: [
        Icon(Icons.info_outline, color: color.secondary, size: 20),
        Text(
          'Informasi',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: color.secondary,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(ColorScheme color, String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.primary.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Text(
            number,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color.primary,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: color.onSurfaceVariant, height: 1.428),
          ),
        ),
      ],
    );
  }
}
