import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sekolah_kita/core/constant/svg_assets.dart';
import 'package:sekolah_kita/features/course/views/widgets/course_card.dart';
import 'package:sekolah_kita/features/course/views/widgets/course_header.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      body: Column(
        children: [
          CourseHeader(),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kategori Kursus',
                  style: TextStyle(
                    fontSize: 20,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16),
                CourseCard(
                  title: 'Literasi Membaca',
                  iconPath: SvgAssets.introReadingIcon,
                  accentColor: color.primary,
                  progress: 0.65,
                  myStars: 3,
                ),
                SizedBox(height: 16),
                CourseCard(
                  title: 'Literasi Menulis',
                  iconPath: SvgAssets.introWritingIcon,
                  accentColor: color.tertiary,
                  progress: 0.42,
                  myStars: 2,
                ),
                SizedBox(height: 16),
                CourseCard(
                  title: 'Numerasi Dasar',
                  iconPath: SvgAssets.introNumerationIcon,
                  accentColor: color.secondary,
                  progress: 0.78,
                  myStars: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
