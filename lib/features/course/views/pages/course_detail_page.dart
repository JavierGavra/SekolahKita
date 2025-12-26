import 'package:flutter/material.dart';
import '../../models/course_model.dart';
import '../../services/course_services.dart';
import '../widgets/course_detail_header.dart';
import '../widgets/progress_card.dart';
import '../widgets/module_card.dart';
import '../widgets/info_card.dart';

class CourseDetailPage extends StatelessWidget {
  const CourseDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CourseModel course = CourseService.getCourseData();

    return Scaffold(
      backgroundColor: const Color(0xFF1A6585),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Kembali',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            CourseDetailHeader(
              title: course.title,
              completedModules: course.completedModules,
              totalModules: course.totalModules,
            ),
            ProgressCard(progress: course.progress),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Daftar Modul',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...course.modules.map(
                        (module) => ModuleCard(module: module),
                      ),
                      const SizedBox(height: 16),
                      const InfoCard(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
