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
    // Module 3: Kuis Menulis Vokal
    QuizModel(
      id: 1,
      moduleId: 3,
      course: CourseType.writing,
      questions: [
        // Soal 1: Trace huruf A
        WritingTraceQuestion(id: 1, target: 'A'),

        // Soal 2: Identifikasi huruf E
        LetterIdentificationQuestion(
          id: 2,
          question: 'Pilihlah huruf E yang benar!',
          imagePath: '👉',
          options: ['A', 'E', 'I', 'O'],
          correctAnswerId: 1,
        ),

        // Soal 3: Trace huruf I
        WritingTraceQuestion(id: 3, target: 'I'),

        // Soal 4: Identifikasi huruf O
        LetterIdentificationQuestion(
          id: 4,
          question: 'Manakah huruf O?',
          imagePath: '🔍',
          options: ['U', 'O', 'A', 'E'],
          correctAnswerId: 1,
        ),

        // Soal 5: Trace huruf U
        WritingTraceQuestion(id: 5, target: 'U'),

        // Soal 6: Matching huruf vokal besar dengan kecil
        LetterMatchingQuestion(
          id: 6,
          question: 'Cocokkan huruf besar dengan huruf kecil yang sesuai!',
          imagePath: '🔗',
          leftItems: ['A', 'E', 'I'],
          rightItems: ['i', 'a', 'e'],
          correctPairs: {
            0: 1, // A -> a
            1: 2, // E -> e
            2: 0, // I -> i
          },
        ),

        // Soal 7: Identifikasi huruf vokal
        LetterIdentificationQuestion(
          id: 7,
          question: 'Manakah yang bukan huruf vokal?',
          imagePath: '❓',
          options: ['A', 'B', 'E', 'I'],
          correctAnswerId: 1,
        ),

        // Soal 8: Trace huruf E kecil
        WritingTraceQuestion(id: 8, target: 'e'),

        // Soal 9: Urutan huruf vokal
        LetterIdentificationQuestion(
          id: 9,
          question: 'Huruf apa yang datang setelah I?',
          imagePath: '➡️',
          options: ['E', 'A', 'O', 'U'],
          correctAnswerId: 2,
        ),

        // Soal 10: Trace huruf O kecil
        WritingTraceQuestion(id: 10, target: 'o'),

        // Soal 11: Identifikasi huruf A
        LetterIdentificationQuestion(
          id: 11,
          question: 'Pilihlah huruf A yang benar!',
          imagePath: '🅰️',
          options: ['O', 'A', 'U', 'E'],
          correctAnswerId: 1,
        ),

        // Soal 12: Trace huruf a kecil
        WritingTraceQuestion(id: 12, target: 'a'),

        // Soal 13: Matching huruf vokal (versi 2)
        LetterMatchingQuestion(
          id: 13,
          question: 'Cocokkan huruf yang sama!',
          imagePath: '🎯',
          leftItems: ['O', 'U', 'A'],
          rightItems: ['a', 'u', 'o'],
          correctPairs: {
            0: 2, // O -> o
            1: 1, // U -> u
            2: 0, // A -> a
          },
        ),

        // Soal 14: Identifikasi huruf I
        LetterIdentificationQuestion(
          id: 14,
          question: 'Manakah huruf I?',
          imagePath: 'ℹ️',
          options: ['L', 'I', 'J', 'T'],
          correctAnswerId: 1,
        ),

        // Soal 15: Trace huruf u kecil
        WritingTraceQuestion(id: 15, target: 'u'),
      ],
    ),
  ];
}
