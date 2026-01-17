import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/quiz_model.dart';
import 'package:sekolah_kita/core/database/static/models/quiz_question_model.dart';
import 'package:sekolah_kita/core/database/static/models/question/writing_trace_question.dart';

//Model tamabhaan untuk kuis menulis

/// Pilihan ganda untuk identifikasi huruf (4 pilihan)
class LetterIdentificationQuestion extends QuizQuestionModel {
  /// Pertanyaan yang akan ditampilkan
  final String question;

  /// Opsional (emoji atau icon)
  final String? imagePath;

  /// Pilihan huruf (4 pilihan)
  final List<String> options;

  /// Index jawaban benar dari array [options]
  final int correctAnswerId;

  LetterIdentificationQuestion({
    required super.id,
    required this.question,
    this.imagePath,
    required this.options,
    required this.correctAnswerId,
  }) : super(type: QuizQuestionType.multipleChooice);
}

/// Model untuk pertanyaan mencocokkan huruf
class LetterMatchingQuestion extends QuizQuestionModel {
  /// Pertanyaan yang akan ditampilkan
  final String question;

  /// Opsional
  final String? imagePath;

  /// Item di sebelah kiri yang harus dicocokkan
  final List<String> leftItems;

  /// Item di sebelah kanan untuk dicocokkan
  final List<String> rightItems;

  /// Pasangan jawaban yang benar
  /// Map<leftIndex, rightIndex>
  final Map<int, int> correctPairs;

  LetterMatchingQuestion({
    required super.id,
    required this.question,
    this.imagePath,
    required this.leftItems,
    required this.rightItems,
    required this.correctPairs,
  }) : super(type: QuizQuestionType.multipleChooice);
}

class WritingQuizData {
  List<QuizQuestionModel> getQuestion(int moduleId) {
    return _quizData
        .firstWhere((element) => element.moduleId == moduleId)
        .questions;
  }

  final List<QuizModel> _quizData = [
    QuizModel(
      id: 1,
      moduleId: 3,
      course: CourseType.writing,
      questions: [
        WritingTraceQuestion(id: 1, target: 'A'),
        WritingTraceQuestion(id: 2, target: 'E'),
        WritingTraceQuestion(id: 3, target: 'C'),
        WritingTraceQuestion(id: 4, target: 'B'),
        WritingTraceQuestion(id: 5, target: 'D'),
      ],
    ),
    QuizModel(
      id: 1,
      moduleId: 5,
      course: CourseType.writing,
      questions: [
        WritingTraceQuestion(id: 1, target: 'J'),
        WritingTraceQuestion(id: 2, target: 'G'),
        WritingTraceQuestion(id: 3, target: 'I'),
        WritingTraceQuestion(id: 4, target: 'H'),
        WritingTraceQuestion(id: 5, target: 'F'),
      ],
    ),
    QuizModel(
      id: 1,
      moduleId: 7,
      course: CourseType.writing,
      questions: [
        WritingTraceQuestion(id: 1, target: 'M'),
        WritingTraceQuestion(id: 2, target: 'L'),
        WritingTraceQuestion(id: 3, target: 'N'),
        WritingTraceQuestion(id: 4, target: 'K'),
        WritingTraceQuestion(id: 5, target: 'O'),
      ],
    ),
    QuizModel(
      id: 1,
      moduleId: 9,
      course: CourseType.writing,
      questions: [
        WritingTraceQuestion(id: 1, target: 'Q'),
        WritingTraceQuestion(id: 2, target: 'R'),
        WritingTraceQuestion(id: 3, target: 'T'),
        WritingTraceQuestion(id: 4, target: 'S'),
        WritingTraceQuestion(id: 5, target: 'P'),
      ],
    ),
    QuizModel(
      id: 1,
      moduleId: 11,
      course: CourseType.writing,
      questions: [
        WritingTraceQuestion(id: 1, target: 'U'),
        WritingTraceQuestion(id: 2, target: 'X'),
        WritingTraceQuestion(id: 3, target: 'V'),
        WritingTraceQuestion(id: 4, target: 'Y'),
        WritingTraceQuestion(id: 5, target: 'W'),
        WritingTraceQuestion(id: 6, target: 'Z'),
      ],
    ),
  ];
}
