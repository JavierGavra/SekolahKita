import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/constant/svg_assets.dart';
import 'package:sekolah_kita/core/utils/navigate/navigate.dart';
import 'package:sekolah_kita/features/course/views/pages/course_detail_page.dart';

class ContinueCourseCard extends StatelessWidget {
  final CourseType type;
  final double progress;
  final int myStars;

  const ContinueCourseCard({
    super.key,
    required this.type,
    required this.progress,
    required this.myStars,
  });

  void _onTap(BuildContext context) =>
      Navigate.push(context, CourseDetailPage(type: type));

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    Color accentColor = switch (type) {
      CourseType.reading => color.primary,
      CourseType.writing => color.tertiary,
      CourseType.numeration => color.secondary,
    };

    return InkWell(
      onTap: () => _onTap(context),
      splashColor: color.primaryContainer,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        padding: const EdgeInsets.fromLTRB(16, 16, 20, 16),
        decoration: BoxDecoration(
          color: color.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.secondaryContainer),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 22,
          children: [
            _buildIcon(accentColor),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle(),
                  SizedBox(height: 12),
                  ..._buildProgress(color, accentColor),
                  SizedBox(height: 8),
                  _buildStars(color),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(Color accentColor) {
    String iconPath = switch (type) {
      CourseType.reading => SvgAssets.introReadingIcon,
      CourseType.writing => SvgAssets.introWritingIcon,
      CourseType.numeration => SvgAssets.introNumerationIcon,
    };

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        Positioned(
          bottom: -6,
          right: -6,
          child: SvgPicture.asset(iconPath, width: 40, height: 40),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      switch (type) {
        CourseType.reading => "Literasi Membaca",
        CourseType.writing => "Literasi Menulis",
        CourseType.numeration => "Numerasi Dasar",
      },
      style: TextStyle(fontSize: 16, height: 1.5, fontWeight: FontWeight.w600),
    );
  }

  List<Widget> _buildProgress(ColorScheme color, Color accentColor) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Progress",
            style: TextStyle(
              color: color.onSurfaceVariant,
              fontSize: 12,
              height: 1.333,
            ),
          ),
          Text(
            "${(progress * 100).round()}%",
            style: TextStyle(
              color: accentColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
              height: 1.333,
            ),
          ),
        ],
      ),
      SizedBox(height: 6),
      TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: progress.clamp(0.0, 1.0)),
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return LinearProgressIndicator(
            value: value,
            minHeight: 6,
            color: accentColor,
            borderRadius: BorderRadius.circular(6),
            backgroundColor: color.surfaceContainerHigh,
          );
        },
      ),
    ];
  }

  Widget _buildStars(ColorScheme color) {
    return Row(
      children: [
        ...List.generate(5, (index) {
          if (index < myStars) {
            return Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Icon(
                Icons.star_rounded,
                size: 16,
                color: const Color(0xFFF57C00),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Icon(
                Icons.star_border_rounded,
                size: 16,
                color: color.secondaryContainer,
              ),
            );
          }
        }),
        Padding(
          padding: EdgeInsets.only(right: 2),
          child: Text(
            "$myStars/5",
            style: TextStyle(
              color: color.onSurfaceVariant,
              fontSize: 12,
              height: 1.333,
            ),
          ),
        ),
      ],
    );
  }
}
