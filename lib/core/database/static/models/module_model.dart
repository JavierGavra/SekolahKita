import 'package:sekolah_kita/core/constant/enum.dart';

class ModuleModel {
  final int id;
  final String title;
  final ModuleType type;
  final CourseType course;
  final bool isStar;

  const ModuleModel({
    required this.id,
    required this.course,
    required this.title,
    required this.type,
    this.isStar = false,
  });

  ModuleModel copyWith({bool? isStar}) {
    return ModuleModel(
      id: id,
      title: title,
      type: type,
      course: course,
      isStar: isStar ?? this.isStar,
    );
  }
}
