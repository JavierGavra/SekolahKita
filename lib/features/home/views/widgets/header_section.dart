import 'package:flutter/material.dart';
import 'package:sekolah_kita/core/database/local_data_persisance.dart';
import 'package:sekolah_kita/core/widgets/online_chip.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      color: color.primary,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
      child: SafeArea(
        child: Column(
          children: [
            _buildGreeting(color),
            SizedBox(height: 24),
            _buildQuickInfo(color),
          ],
        ),
      ),
    );
  }

  Widget _buildGreeting(ColorScheme color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat Siang,',
              style: TextStyle(
                color: color.surfaceContainerHighest,
                height: 1.714,
              ),
            ),
            Text(
              LocalDataPersisance().getUsername ?? '----',
              style: TextStyle(
                color: color.onPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
          ],
        ),
        OnlineChip(),
      ],
    );
  }

  Widget _buildQuickInfo(ColorScheme color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 10,
      children: [
        _buildQuickInfoItem(
          color,
          Icons.trending_up_rounded,
          "Progress",
          "67%",
        ),
        _buildQuickInfoItem(color, Icons.book_rounded, "Modul", "12"),
        _buildQuickInfoItem(color, Icons.stars_rounded, "Bintang", "9/15"),
      ],
    );
  }

  Widget _buildQuickInfoItem(
    ColorScheme color,
    IconData icon,
    String title,
    String value,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.surfaceContainer.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: (title == "Bintang") ? Color(0xFFF57C00) : color.onPrimary,
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: color.onPrimary.withValues(alpha: 0.7),
                fontSize: 12,
                height: 1.333,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: color.onPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
