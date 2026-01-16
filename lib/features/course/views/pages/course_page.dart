import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/features/course/cubit/course/course_cubit.dart';
import 'package:sekolah_kita/features/course/services/local_service.dart';
import 'package:sekolah_kita/features/course/views/widgets/course_card.dart';
import 'package:sekolah_kita/features/course/views/widgets/course_header.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CourseCubit, CourseState>(
        builder: (context, state) {
          return Column(
            children: [
              const CourseHeader(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
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
                      // myStars: state.readingStar,
                    ),
                    const SizedBox(height: 16),
                    CourseCard(
                      type: CourseType.writing,
                      progress: LocalService().getCourseProgress(
                        CourseType.writing,
                      ),
                      // myStars: state.writingStar,
                    ),
                    const SizedBox(height: 16),
                    CourseCard(
                      type: CourseType.numeration,
                      progress: LocalService().getCourseProgress(
                        CourseType.numeration,
                      ),
                      // myStars: state.numerationsStar,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
