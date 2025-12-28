import 'package:flutter/material.dart';
import 'package:sekolah_kita/features/course/models/course_types.dart';
import '../../models/course_model.dart';
import '../../services/course_services.dart';
import '../widgets/course_detail_header.dart';
import '../widgets/module_card.dart';
import '../widgets/info_card.dart';

class CourseDetailPage extends StatelessWidget {
  final CourseType type;

  const CourseDetailPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final CourseModel course = CourseService.getCourseData();

    return Scaffold(
      backgroundColor: color.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CourseDetailHeader(
              completedModules: course.completedModules,
              totalModules: course.totalModules,
              progress: course.progress,
              type: type,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 48),
              decoration: BoxDecoration(
                color: color.surface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Daftar Modul',
                    style: TextStyle(
                      fontSize: 20,
                      height: 1.4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...course.modules.map(
                    (module) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ModuleCard(module: module, type: type),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const InfoCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
