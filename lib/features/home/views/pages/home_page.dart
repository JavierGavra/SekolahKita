import 'package:flutter/material.dart';
import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/local_data_persisance.dart';
import 'package:sekolah_kita/features/home/views/widgets/continue_course_card.dart';
import 'package:sekolah_kita/features/home/views/widgets/greeting_card.dart';
import 'package:sekolah_kita/features/home/views/widgets/header_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final localData = LocalDataPersisance();
    CourseType? lastCourse = switch (localData.getLastCourse) {
      "reading" => CourseType.reading,
      "writing" => CourseType.writing,
      "numeration" => CourseType.numeration,
      String() => null,
      null => null,
    };

    return Scaffold(
      body: Column(
        children: [
          HeaderSection(),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lanjutkan Belajar',
                  style: TextStyle(
                    fontSize: 20,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (lastCourse != null) ...[
                  SizedBox(height: 16),
                  ContinueCourseCard(
                    type: lastCourse,
                    progress: 0.67,
                    myStars: 3,
                  ),
                ],
                SizedBox(height: 16),
                GreetingCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
