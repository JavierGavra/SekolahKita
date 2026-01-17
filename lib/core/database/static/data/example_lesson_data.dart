import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_model.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section/audio_section.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section/multiple_choice_section.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section/text_section.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section_model.dart';

class ExampleLessonData {
  List<LessonSectionModel> getLessonSection() {
    return _lessonData.first.lessonSections;
  }

  final List<LessonModel> _lessonData = [
    LessonModel(
      /// Di isi sesuai urutan array nya saja (index + 1)
      id: 1,
      moduleId: 1,

      /// Lesson ini ada pada Kategori Course apa
      course: CourseType.reading,
      lessonSections: [
        MultipleChoiceSection(
          id: 1,
          text: "Ada berapa apel di bawah ini\n🍎🍎🍎🍎",
          options: ["5", '4'],
          correctAnswerId: 1,
        ),
        AudioSection(id: 1, text: "A | a", textToSpeech: "A"),
        AudioSection(id: 1, text: "I | i", textToSpeech: "I"),
        AudioSection(id: 1, text: "U | u", textToSpeech: "U"),
        AudioSection(id: 1, text: "E | e", textToSpeech: "E"),
        AudioSection(id: 1, text: "O | o", textToSpeech: "O"),
      ],
    ),
    LessonModel(
      /// Di isi sesuai urutan array nya saja (index + 1)
      id: 1,
      moduleId: 3,

      /// Lesson ini ada pada Kategori Course apa
      course: CourseType.reading,
      lessonSections: [
        TextSection(
          id: 1,
          text: "1 = Satu\n2 = Dua\n3 = Tiga\n4 = Empat\n5 = Lima",
        ),
      ],
    ),
  ];
}
