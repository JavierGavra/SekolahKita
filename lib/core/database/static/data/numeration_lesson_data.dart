import 'package:sekolah_kita/core/database/static/models/lesson_model.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section_model.dart';

class NumerationLessonData {
  List<LessonSectionModel> getLessonSection(int moduleId) {
    return _lessonData
        .firstWhere((element) => element.moduleId == moduleId)
        .lessonSections;
  }

  final List<LessonModel> _lessonData = [];
}
