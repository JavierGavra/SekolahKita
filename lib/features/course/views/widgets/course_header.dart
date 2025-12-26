import 'package:flutter/material.dart';
import 'package:sekolah_kita/core/widgets/online_chip.dart';

class CourseHeader extends StatelessWidget {
  const CourseHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      color: color.primary,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildGreeting(color),
            SizedBox(height: 24),
            _buildProgress(color),
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
              'Mari kita belajar bersama,',
              style: TextStyle(
                color: color.surfaceContainerHighest,
                height: 1.714,
              ),
            ),
            Text(
              'Ahmad Rusdi',
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

  Widget _buildProgress(ColorScheme color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.surfaceContainer.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 10,
                children: [
                  Icon(
                    Icons.trending_up_rounded,
                    color: color.onPrimary,
                    size: 20,
                  ),
                  Text(
                    'Progress Belajar Anda',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: color.onPrimary,
                      fontSize: 14,
                      height: 1.428,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: Text(
                  '62%',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: color.onPrimary,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: 0.62,
              minHeight: 8,
              backgroundColor: color.primary,
              valueColor: AlwaysStoppedAnimation<Color>(color.primaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}
