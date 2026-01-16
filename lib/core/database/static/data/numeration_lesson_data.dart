import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_model.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section/text_section.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section_model.dart';

class NumerationLessonData {
  List<LessonSectionModel> getLessonSection(int moduleId) {
    return _lessonData
        .firstWhere((element) => element.moduleId == moduleId)
        .lessonSections;
  }

  final List<LessonModel> _lessonData = [
    LessonModel(
      id: 1,
      moduleId: 1,
      course: CourseType.numeration,
      lessonSections: [TextSection(id: 1, text: "Hello World")],
    ),
    LessonModel(
      id: 2,
      moduleId: 3,
      course: CourseType.numeration,
      lessonSections: [TextSection(id: 1, text: "Hello World")],
    ),
    LessonModel(
      id: 3,
      moduleId: 5,
      course: CourseType.numeration,
      lessonSections: [TextSection(id: 1, text: "Hello World")],
    ),
    LessonModel(
      id: 4,
      moduleId: 7,
      course: CourseType.numeration,
      lessonSections: [TextSection(id: 1, text: "Hello World")],
    ),
  ];
}
