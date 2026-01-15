import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sekolah_kita/core/constant/svg_assets.dart';
import 'package:sekolah_kita/core/constant/enum.dart';

class CourseDetailHeader extends StatelessWidget {
  final int completedModules;
  final int totalModules;
  final double progress;
  final CourseType type;

  const CourseDetailHeader({
    super.key,
    required this.completedModules,
    required this.totalModules,
    required this.progress,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    Color backgroundColor, foregroundColor;

    switch (type) {
      case CourseType.reading:
        backgroundColor = color.primary;
        foregroundColor = color.primaryContainer;
        break;
      case CourseType.writing:
        backgroundColor = color.tertiary;
        foregroundColor = color.tertiaryContainer;
        break;
      default:
        backgroundColor = color.secondary;
        foregroundColor = color.secondaryContainer;
        break;
    }

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 22, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            _buildBackButton(context, color),
            _buildTitle(color, foregroundColor),
            _buildProgressCard(color, foregroundColor, backgroundColor),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context, ColorScheme color) {
    return InkWell(
      onTap: () => Navigator.maybePop(context),
      borderRadius: BorderRadius.circular(8),
      splashColor: color.onSurfaceVariant,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(2, 2, 10, 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            Icon(
              Icons.arrow_back_ios_rounded,
              color: color.onPrimary,
              size: 20,
            ),
            Text(
              'Kembali',
              style: TextStyle(
                color: color.onPrimary,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(ColorScheme color, Color accentColor) {
    return Row(
      spacing: 16,
      children: [
        Stack(
          alignment: AlignmentGeometry.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: color.surfaceContainerLowest.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            SvgPicture.asset(
              switch (type) {
                CourseType.reading => SvgAssets.introReadingIcon,
                CourseType.writing => SvgAssets.introWritingIcon,
                CourseType.numeration => SvgAssets.introNumerationIcon,
              },
              width: 32,
              height: 32,
              colorFilter: ColorFilter.mode(accentColor, BlendMode.srcIn),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            Text(
              switch (type) {
                CourseType.reading => "Literasi Membaca",
                CourseType.writing => "Literasi Menulis",
                CourseType.numeration => "Numerasi Dasar",
              },
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color.onPrimary,
                height: 1.333,
                fontSize: 24,
              ),
            ),
            Text(
              '$completedModules dari $totalModules modul selesai',
              style: TextStyle(
                color: color.onPrimary.withValues(alpha: 0.8),
                height: 1.428,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressCard(ColorScheme color, Color fore, Color back) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.surfaceContainer.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Progress Kategori',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: back,
              valueColor: AlwaysStoppedAnimation<Color>(fore),
              minHeight: 10,
            ),
          ),
        ],
      ),
    );
  }
}
