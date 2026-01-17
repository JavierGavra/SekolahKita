import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_model.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section/audio_section.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section/text_section.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section_model.dart';

class ReadingLessonData {
  List<LessonSectionModel> getLessonSection(int moduleId) {
    return _lessonData
        .firstWhere((element) => element.moduleId == moduleId)
        .lessonSections;
  }

  final List<LessonModel> _lessonData = [
    LessonModel(
      id: 1,
      moduleId: 1,
      course: CourseType.reading,
      lessonSections: [
        TextSection(id: 1, text: "Belajar cara melafalkan huruf vokal"),
        AudioSection(id: 2, text: "A | a", textToSpeech: "A"),
        AudioSection(id: 3, text: "I | i", textToSpeech: "I"),
        AudioSection(id: 4, text: "U | u", textToSpeech: "U"),
        AudioSection(id: 5, text: "E | e", textToSpeech: "E"),
        AudioSection(id: 6, text: "O | o", textToSpeech: "O"),
      ],
    ),
    LessonModel(
      id: 1,
      moduleId: 3,
      course: CourseType.reading,
      lessonSections: [
        TextSection(id: 1, text: "Belajar cara melafalkan huruf konsonan"),
        AudioSection(id: 2, text: "B | b", textToSpeech: "B"),
        AudioSection(id: 3, text: "C | c", textToSpeech: "C"),
        AudioSection(id: 4, text: "D | d", textToSpeech: "D"),
        AudioSection(id: 5, text: "F | f", textToSpeech: "F"),
        AudioSection(id: 6, text: "G | g", textToSpeech: "G"),
        AudioSection(id: 7, text: "H | h", textToSpeech: "H"),
        AudioSection(id: 8, text: "J | j", textToSpeech: "J"),
        AudioSection(id: 9, text: "K | k", textToSpeech: "K"),
        AudioSection(id: 10, text: "L | l", textToSpeech: "L"),
        AudioSection(id: 11, text: "M | m", textToSpeech: "M"),
        AudioSection(id: 12, text: "N | n", textToSpeech: "N"),
        AudioSection(id: 13, text: "P | p", textToSpeech: "P"),
        AudioSection(id: 14, text: "Q | q", textToSpeech: "Q"),
        AudioSection(id: 15, text: "R | r", textToSpeech: "R"),
        AudioSection(id: 16, text: "S | s", textToSpeech: "S"),
        AudioSection(id: 17, text: "T | t", textToSpeech: "T"),
        AudioSection(id: 18, text: "V | v", textToSpeech: "V"),
        AudioSection(id: 19, text: "W | w", textToSpeech: "W"),
        AudioSection(id: 20, text: "X | x", textToSpeech: "X"),
        AudioSection(id: 21, text: "Y | y", textToSpeech: "Y"),
        AudioSection(id: 22, text: "Z | z", textToSpeech: "Z"),
      ],
    ),
    LessonModel(
      id: 1,
      moduleId: 5,
      course: CourseType.reading,
      lessonSections: [
        TextSection(id: 1, text: "Belajar Suku Kata"),
        TextSection(id: 2, text: "B-U = BU"),
        TextSection(id: 3, text: "D-I = DI"),
        AudioSection(id: 4, text: "Budi", textToSpeech: "Budi"),
        TextSection(id: 5, text: "M-O = MO"),
        TextSection(id: 6, text: "B-I-L = BIL"),
        AudioSection(id: 7, text: "Mobil", textToSpeech: "Mobil"),
        TextSection(id: 8, text: "B-A  = BA"),
        TextSection(id: 9, text: "P-A-K = PAK"),
        AudioSection(id: 10, text: "Bapak", textToSpeech: "Bapak"),
      ],
    ),
    LessonModel(
      id: 1,
      moduleId: 7,
      course: CourseType.reading,
      lessonSections: [
        TextSection(id: 1, text: "Belajar Kata Sederhana"),
        TextSection(id: 2, text: "Ini"),
        TextSection(id: 3, text: "Ibu"),
        TextSection(id: 4, text: "Budi"),
        AudioSection(id: 5, text: "Ini Ibu Budi", textToSpeech: "Ini ibu Budi"),
        TextSection(id: 6, text: "Saya"),
        TextSection(id: 7, text: "Pergi"),
        TextSection(id: 8, text: "Sekolah"),
        AudioSection(
          id: 9,
          text: "Saya Pergi Sekolah",
          textToSpeech: "Saya pergi sekolah",
        ),
        TextSection(id: 10, text: "Apel"),
        TextSection(id: 11, text: "Itu"),
        TextSection(id: 12, text: "Buah"),
        AudioSection(
          id: 13,
          text: "Apel Itu Buah",
          textToSpeech: "Apel itu buah",
        ),
      ],
    ),
  ];
}
