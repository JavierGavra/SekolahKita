import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section_model.dart';

class LessonModel {
  final int id;
  final int moduleId;
  final CourseType course;
  final List<LessonSectionModel> lessonSections;

  const LessonModel({
    required this.id,
    required this.moduleId,
    required this.course,
    required this.lessonSections,
  });

  int get totalQuestions => lessonSections.length;
}
