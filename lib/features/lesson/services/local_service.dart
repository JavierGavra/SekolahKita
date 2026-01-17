import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/data/numeration_lesson_data.dart';
import 'package:sekolah_kita/core/database/static/data/reading_lesson_data.dart';
import 'package:sekolah_kita/core/database/static/data/writing_lesson_data.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section_model.dart';

class LocalService {
  List<LessonSectionModel> getSections(CourseType type, int moduleId) {
    return switch (type) {
      CourseType.reading => ReadingLessonData().getLessonSection(moduleId),
      CourseType.writing => WritingLessonData().getLessonSection(moduleId),
      CourseType.numeration => NumerationLessonData().getLessonSection(
        moduleId,
      ),
    };
  }
}
