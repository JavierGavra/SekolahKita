import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_model.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section/draw_letter_section.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section/text_section.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section_model.dart';

class WritingLessonData {
  List<LessonSectionModel> getLessonSection(int moduleId) {
    return _lessonData
        .firstWhere((element) => element.moduleId == moduleId)
        .lessonSections;
  }

  String get animationPath => "assets/animations/";

  List<LessonModel> get _lessonData => [
    LessonModel(
      id: 1,
      moduleId: 1,
      course: CourseType.writing,
      lessonSections: [
        TextSection(id: 1, text: "Cara memegang pensil"),
        TextSection(
          id: 1,
          text:
              'Pegang pensil dengan tiga jari: ibu jari, jari telunjuk, dan jari tengah',
        ),
        TextSection(
          id: 1,
          text: 'Jari manis dan kelingking sebagai penopang di bawah',
        ),
        TextSection(
          id: 1,
          text:
              'Jangan terlalu keras memegang pensil\n\nPosisi pensil miring sekitar 45 derajat\n\nJarak jari ke ujung pensil sekitar 2-3 cm',
        ),
      ],
    ),
    LessonModel(
      id: 2,
      moduleId: 2,
      course: CourseType.writing,
      lessonSections: [
        TextSection(id: 1, text: "Belajar cara menulis huruf\nA - E"),
        DrawLetterSection(id: 2, text: "A", char: 'A'),
        DrawLetterSection(id: 3, text: "B", char: "B"),
        DrawLetterSection(id: 4, text: "C", char: 'C'),
        DrawLetterSection(id: 5, text: "D", char: 'D'),
        DrawLetterSection(id: 6, text: "E", char: 'E'),
      ],
    ),
    LessonModel(
      id: 2,
      moduleId: 4,
      course: CourseType.writing,
      lessonSections: [
        TextSection(id: 1, text: "Belajar cara menulis huruf\nF - J"),
        DrawLetterSection(id: 2, text: "F", char: 'F'),
        DrawLetterSection(id: 3, text: "G", char: "G"),
        DrawLetterSection(id: 4, text: "H", char: 'H'),
        DrawLetterSection(id: 5, text: "I", char: 'I'),
        DrawLetterSection(id: 6, text: "K", char: 'K'),
      ],
    ),
    LessonModel(
      id: 2,
      moduleId: 6,
      course: CourseType.writing,
      lessonSections: [
        TextSection(id: 1, text: "Belajar cara menulis huruf\nK - O"),
        DrawLetterSection(id: 2, text: "K", char: 'K'),
        DrawLetterSection(id: 3, text: "L", char: "L"),
        DrawLetterSection(id: 4, text: "M", char: 'M'),
        DrawLetterSection(id: 5, text: "N", char: 'N'),
        DrawLetterSection(id: 6, text: "O", char: 'O'),
      ],
    ),
    LessonModel(
      id: 2,
      moduleId: 8,
      course: CourseType.writing,
      lessonSections: [
        TextSection(id: 1, text: "Belajar cara menulis huruf\nP - T"),
        DrawLetterSection(id: 2, text: "P", char: 'P'),
        DrawLetterSection(id: 3, text: "Q", char: "Q"),
        DrawLetterSection(id: 4, text: "R", char: 'R'),
        DrawLetterSection(id: 5, text: "S", char: 'S'),
        DrawLetterSection(id: 6, text: "T", char: 'T'),
      ],
    ),
    LessonModel(
      id: 2,
      moduleId: 10,
      course: CourseType.writing,
      lessonSections: [
        TextSection(id: 1, text: "Belajar cara menulis huruf\nU - Z"),
        DrawLetterSection(id: 2, text: "U", char: 'U'),
        DrawLetterSection(id: 3, text: "V", char: "V"),
        DrawLetterSection(id: 4, text: "W", char: 'W'),
        DrawLetterSection(id: 5, text: "X", char: 'X'),
        DrawLetterSection(id: 6, text: "Y", char: 'Y'),
        DrawLetterSection(id: 7, text: "Z", char: 'Z'),
      ],
    ),
  ];
}
