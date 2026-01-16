import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_model.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section/audio_section.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section/multiple_choice_section.dart';
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
      lessonSections: [
        TextSection(id: 1, text: "Belajar Mengenali Angka"),
        AudioSection(id: 2, text: "1", textToSpeech: "Satu"),
        AudioSection(id: 3, text: "2", textToSpeech: "Dua"),
        AudioSection(id: 4, text: "3", textToSpeech: "Tiga"),
        AudioSection(id: 5, text: "4", textToSpeech: "Empat"),
        AudioSection(id: 6, text: "5", textToSpeech: "Lima"),
        AudioSection(id: 7, text: "6", textToSpeech: "Enam"),
        AudioSection(id: 8, text: "7", textToSpeech: "Tujuh"),
        AudioSection(id: 9, text: "8", textToSpeech: "Delapan"),
        AudioSection(id: 10, text: "9", textToSpeech: "Sembilan"),
        AudioSection(id: 11, text: "10", textToSpeech: "Sepuluh"),
      ],
    ),
    LessonModel(
      id: 2,
      moduleId: 3,
      course: CourseType.numeration,
      lessonSections: [
        TextSection(id: 1, text: "Belajar Menghitung"),
        TextSection(id: 2, text: "🍎 = 1"),
        TextSection(id: 3, text: "🍊🍊 = 2"),
        MultipleChoiceSection(
          id: 4,
          text: "Ada Berapa Buah Di Bawah Ini \n 🍐",
          options: ['1', '2'],
          correctAnswerId: 0,
        ),
        TextSection(id: 5, text: "🍌🍌🍌 = 3"),
        TextSection(id: 6, text: "🥭🥭🥭🥭 = 4"),
        MultipleChoiceSection(
          id: 7,
          text: "Ada Berapa Buah Di Bawah Ini \n 🍇🍇🍇🍇",
          options: ['3', '4'],
          correctAnswerId: 1,
        ),
        TextSection(id: 8, text: "🍈🍈🍈🍈🍈 = 5"),
        TextSection(id: 9, text: "🍉🍉🍉🍉🍉🍉 = 6"),
        MultipleChoiceSection(
          id: 10,
          text: "Ada Berapa Buah Di Bawah Ini \n 🍍🍍🍍🍍🍍",
          options: ['5', '6'],
          correctAnswerId: 0,
        ),
        TextSection(id: 11, text: "🍒🍒🍒🍒🍒🍒🍒 = 7"),
        TextSection(id: 12, text: "🍓🍓🍓🍓🍓🍓🍓🍓 = 8"),
        MultipleChoiceSection(
          id: 13,
          text: "Ada Berapa Buah Di Bawah Ini \n 🍋🍋🍋🍋🍋🍋🍋🍋",
          options: ['7', '8'],
          correctAnswerId: 1,
        ),
        TextSection(id: 14, text: "🥑🥑🥑🥑🥑🥑🥑🥑🥑 = 9"),
        TextSection(id: 15, text: "🥝🥝🥝🥝🥝🥝🥝🥝🥝🥝 = 10"),
        MultipleChoiceSection(
          id: 16,
          text: "Ada Berapa Buah Di Bawah Ini \n 🍅🍅🍅🍅🍅🍅🍅🍅🍅",
          options: ['9', '10'],
          correctAnswerId: 0,
        ),
      ],
    ),
    LessonModel(
      id: 3,
      moduleId: 5,
      course: CourseType.numeration,
      lessonSections: [
        TextSection(id: 1, text: "Belajar Penjumlahan"),
        TextSection(id: 2, text: "1 + 1 = 2 \n 🍎➕🍎 = 🍎🍎"),
        TextSection(id: 3, text: "1 + 2 = 3 \n 🍎➕🍎🍎 = 🍎🍎🍎"),
        TextSection(id: 4, text: "2 + 2 = 4 \n 🍎🍎➕🍎🍎 = 🍎🍎🍎🍎"),
        TextSection(id: 5, text: "2 + 3 = 5 \n 🍎🍎➕🍎🍎🍎 = 🍎🍎🍎🍎🍎"),
        TextSection(id: 6, text: "3 + 3 = 6 \n 🍎🍎🍎➕🍎🍎🍎 = 🍎🍎🍎🍎🍎🍎"),
        TextSection(
          id: 7,
          text: "3 + 4 = 7 \n 🍎🍎🍎➕🍎🍎🍎🍎 = 🍎🍎🍎🍎🍎🍎🍎",
        ),
        TextSection(
          id: 8,
          text: "4 + 4 = 8 \n 🍎🍎🍎🍎➕🍎🍎🍎🍎 = 🍎🍎🍎🍎🍎🍎🍎🍎",
        ),
        TextSection(
          id: 9,
          text: "4 + 5 = 9 \n 🍎🍎🍎🍎➕🍎🍎🍎🍎🍎 = 🍎🍎🍎🍎🍎🍎🍎🍎🍎",
        ),
        TextSection(
          id: 10,
          text: "5 + 5 = 10 \n 🍎🍎🍎🍎🍎➕🍎🍎🍎🍎🍎 = 🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎",
        ),
      ],
    ),
    LessonModel(
      id: 4,
      moduleId: 7,
      course: CourseType.numeration,
      lessonSections: [
        TextSection(id: 1, text: "Belajar Pengurangan"),
        TextSection(
          id: 2,
          text: "10 - 1 = 9 \n 🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎➖🍎 = 🍎🍎🍎🍎🍎🍎🍎🍎🍎",
        ),
        TextSection(
          id: 3,
          text: "10 - 2 = 8 \n 🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎➖🍎🍎 = 🍎🍎🍎🍎🍎🍎🍎🍎",
        ),
        TextSection(
          id: 4,
          text: "9 - 2 = 7 \n 🍎🍎🍎🍎🍎🍎🍎🍎🍎➖🍎🍎 = 🍎🍎🍎🍎🍎🍎🍎",
        ),
        TextSection(
          id: 5,
          text: "9 - 3 = 6 \n 🍎🍎🍎🍎🍎🍎🍎🍎🍎➖🍎🍎🍎 = 🍎🍎🍎🍎🍎🍎",
        ),
        TextSection(
          id: 6,
          text: "8 - 3 = 5 \n 🍎🍎🍎🍎🍎🍎🍎🍎➖🍎🍎🍎 = 🍎🍎🍎🍎🍎",
        ),
        TextSection(
          id: 7,
          text: "8 - 4 = 4 \n 🍎🍎🍎🍎🍎🍎🍎🍎➖🍎🍎🍎🍎 = 🍎🍎🍎🍎",
        ),
        TextSection(
          id: 8,
          text: "7 - 4 = 3 \n 🍎🍎🍎🍎🍎🍎🍎➖🍎🍎🍎🍎 = 🍎🍎🍎",
        ),
        TextSection(
          id: 9,
          text: "7 - 5 = 2 \n 🍎🍎🍎🍎🍎🍎🍎➖🍎🍎🍎🍎🍎 = 🍎🍎",
        ),
        TextSection(id: 10, text: "6 - 5 = 1 \n 🍎🍎🍎🍎🍎🍎➖🍎🍎🍎🍎🍎 = 🍎"),
      ],
    ),
  ];
}
