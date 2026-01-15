import 'package:flutter/material.dart';
import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/local_data_persisance.dart';
import 'package:sekolah_kita/core/database/static/models/module_model.dart';
import '../../services/local_service.dart';
import '../widgets/course_detail_header.dart';
import '../widgets/module_card.dart';
import '../widgets/info_card.dart';

class CourseDetailPage extends StatelessWidget {
  final CourseType type;

  const CourseDetailPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    int lastModuleIndex = LocalDataPersisance().getLastModuleIndex(type) ?? -1;
    final List<ModuleModel> modules = switch (type) {
      CourseType.reading => LocalService().getReadingModules(),
      CourseType.writing => LocalService().getWritingModules(),
      CourseType.numeration => LocalService().getNumerationModules(),
    };

    return Scaffold(
      backgroundColor: color.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CourseDetailHeader(
              completedModules: 2,
              totalModules: modules.length,
              progress: 0.2,
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
                  ...modules.map(
                    (module) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ModuleCard(
                        module: module,
                        type: type,
                        isLocked: module.id > lastModuleIndex + 1,
                        isCompleted: module.id <= lastModuleIndex,
                      ),
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
