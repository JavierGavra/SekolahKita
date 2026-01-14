import 'package:flutter/material.dart';
import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/features/course/services/local_service.dart';
import 'package:sekolah_kita/features/course/views/widgets/course_card.dart';
import 'package:sekolah_kita/features/course/views/widgets/course_header.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CourseHeader(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                const SizedBox(height: 16),
                CourseCard(
                  type: CourseType.reading,
                  progress: LocalService().getCourseProgress(
                    CourseType.reading,
                  ),
                  myStars: 3,
                ),
                const SizedBox(height: 16),
                CourseCard(
                  type: CourseType.writing,
                  progress: LocalService().getCourseProgress(
                    CourseType.writing,
                  ),
                  myStars: 2,
                ),
                const SizedBox(height: 16),
                CourseCard(
                  type: CourseType.numeration,
                  progress: LocalService().getCourseProgress(
                    CourseType.numeration,
                  ),
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
