import 'package:flutter/material.dart';
import 'package:sekolah_kita/features/course/models/course_types.dart';
import 'package:sekolah_kita/features/course/views/widgets/course_card.dart';
import 'package:sekolah_kita/features/course/views/widgets/course_header.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CourseHeader(),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: const Column(
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
                  type: CourseType.reading,
                  progress: 0.65,
                  myStars: 3,
                ),
                SizedBox(height: 16),
                CourseCard(
                  type: CourseType.writing,
                  progress: 0.42,
                  myStars: 2,
                ),
                SizedBox(height: 16),
                CourseCard(
                  type: CourseType.numeration,
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
