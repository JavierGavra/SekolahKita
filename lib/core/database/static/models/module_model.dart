import 'package:sekolah_kita/core/constant/enum.dart';

class ModuleModel {
  final int id;
  final String title;
  final ModuleType type;
  final CourseType course;

  const ModuleModel({
    required this.id,
    required this.course,
    required this.title,
    required this.type,
  });
}
