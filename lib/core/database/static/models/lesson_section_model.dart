import 'package:sekolah_kita/core/constant/enum.dart';

abstract class LessonSectionModel {
  final int id;
  final LessonSectionType type;

  const LessonSectionModel({required this.id, required this.type});
}
