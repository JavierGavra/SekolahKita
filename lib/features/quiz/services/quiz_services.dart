// lib/features/quiz/services/quiz_service.dart

import '../models/quiz_models.dart';

class QuizService {
  // Simulate API call to get quiz data
  Future<Quiz> getQuiz(String moduleId) async {
    await Future.delayed(const Duration(seconds: 1));

    // Mock data - replace with actual API call
    return Quiz(
      id: 'quiz_1',
      courseId: 'course_1',
      moduleId: moduleId,
      title: 'Pengenalan Flutter & Dart',
      description: 'Ujian pemahaman dasar tentang Flutter dan Dart',
      totalQuestions: 10,
      timeLimit: 15, // 15 minutes
      passingScore: 70,
      questionTypes: ['Pilihan Ganda', 'Benar/Salah'],
      rules: [
        'Setiap soal memiliki bobot nilai yang sama',
        'Tidak ada pengurangan nilai untuk jawaban salah',
        'Jawaban tidak dapat diubah setelah submit',
        'Quiz harus diselesaikan dalam waktu yang ditentukan',
        'Anda harus mencapai passing score untuk melanjutkan',
      ],
      questions: _generateMockQuestions(),
    );
  }

  List<Question> _generateMockQuestions() {
    return [
      Question(
        id: 'q1',
        number: 1,
        text: 'Apa yang dimaksud dengan Widget dalam Flutter?',
        type: QuestionType.multipleChoice,
        options: [
          AnswerOption(id: 'a1', text: 'Bahasa pemrograman'),
          AnswerOption(id: 'a2', text: 'Elemen UI dasar dalam Flutter'),
          AnswerOption(id: 'a3', text: 'Database'),
          AnswerOption(id: 'a4', text: 'Web browser'),
        ],
        correctAnswerId: 'a2',
      ),
      Question(
        id: 'q2',
        number: 2,
        text: 'Flutter menggunakan bahasa pemrograman Dart.',
        type: QuestionType.trueFalse,
        options: [
          AnswerOption(id: 'a1', text: 'Benar'),
          AnswerOption(id: 'a2', text: 'Salah'),
        ],
        correctAnswerId: 'a1',
      ),
      Question(
        id: 'q3',
        number: 3,
        text: 'Apa fungsi dari StatefulWidget?',
        type: QuestionType.multipleChoice,
        options: [
          AnswerOption(id: 'a1', text: 'Widget yang tidak pernah berubah'),
          AnswerOption(
            id: 'a2',
            text: 'Widget yang memiliki state yang dapat berubah',
          ),
          AnswerOption(id: 'a3', text: 'Widget untuk database'),
          AnswerOption(id: 'a4', text: 'Widget untuk animasi saja'),
        ],
        correctAnswerId: 'a2',
      ),
      Question(
        id: 'q4',
        number: 4,
        text:
            'Hot Reload di Flutter memungkinkan developer melihat perubahan secara instan tanpa restart aplikasi.',
        type: QuestionType.trueFalse,
        options: [
          AnswerOption(id: 'a1', text: 'Benar'),
          AnswerOption(id: 'a2', text: 'Salah'),
        ],
        correctAnswerId: 'a1',
      ),
      Question(
        id: 'q5',
        number: 5,
        text: 'Widget mana yang digunakan untuk membuat layout vertikal?',
        type: QuestionType.multipleChoice,
        options: [
          AnswerOption(id: 'a1', text: 'Row'),
          AnswerOption(id: 'a2', text: 'Column'),
          AnswerOption(id: 'a3', text: 'Stack'),
          AnswerOption(id: 'a4', text: 'Container'),
        ],
        correctAnswerId: 'a2',
      ),
      Question(
        id: 'q6',
        number: 6,
        text: 'Apa kepanjangan dari SDK?',
        type: QuestionType.multipleChoice,
        options: [
          AnswerOption(id: 'a1', text: 'Software Development Kit'),
          AnswerOption(id: 'a2', text: 'System Development Kit'),
          AnswerOption(id: 'a3', text: 'Standard Development Key'),
          AnswerOption(id: 'a4', text: 'Secure Development Kit'),
        ],
        correctAnswerId: 'a1',
      ),
      Question(
        id: 'q7',
        number: 7,
        text: 'Flutter hanya dapat digunakan untuk membuat aplikasi Android.',
        type: QuestionType.trueFalse,
        options: [
          AnswerOption(id: 'a1', text: 'Benar'),
          AnswerOption(id: 'a2', text: 'Salah'),
        ],
        correctAnswerId: 'a2',
      ),
      Question(
        id: 'q8',
        number: 8,
        text: 'Apa fungsi dari MaterialApp widget?',
        type: QuestionType.multipleChoice,
        options: [
          AnswerOption(id: 'a1', text: 'Menampilkan gambar'),
          AnswerOption(id: 'a2', text: 'Root widget untuk Material Design'),
          AnswerOption(id: 'a3', text: 'Menyimpan data'),
          AnswerOption(id: 'a4', text: 'Membuat animasi'),
        ],
        correctAnswerId: 'a2',
      ),
      Question(
        id: 'q9',
        number: 9,
        text: 'Dart adalah bahasa pemrograman yang dikembangkan oleh Google.',
        type: QuestionType.trueFalse,
        options: [
          AnswerOption(id: 'a1', text: 'Benar'),
          AnswerOption(id: 'a2', text: 'Salah'),
        ],
        correctAnswerId: 'a1',
      ),
      Question(
        id: 'q10',
        number: 10,
        text: 'Widget mana yang digunakan untuk membuat tombol di Flutter?',
        type: QuestionType.multipleChoice,
        options: [
          AnswerOption(id: 'a1', text: 'Text'),
          AnswerOption(id: 'a2', text: 'Container'),
          AnswerOption(id: 'a3', text: 'ElevatedButton'),
          AnswerOption(id: 'a4', text: 'Image'),
        ],
        correctAnswerId: 'a3',
      ),
    ];
  }

  // Submit quiz and calculate result
  Future<QuizResult> submitQuiz({
    required Quiz quiz,
    required Map<String, QuizAnswer> answers,
    required Duration timeUsed,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    int correctCount = 0;
    List<QuestionResult> questionResults = [];

    for (var question in quiz.questions) {
      final answer = answers[question.id];
      final isCorrect =
          answer != null &&
          answer.selectedOptionIds.isNotEmpty &&
          answer.selectedOptionIds.first == question.correctAnswerId;

      if (isCorrect) correctCount++;

      questionResults.add(
        QuestionResult(
          questionId: question.id,
          questionNumber: question.number,
          questionText: question.text,
          isCorrect: isCorrect,
          selectedOptionIds: answer?.selectedOptionIds ?? [],
          correctAnswerId: question.correctAnswerId,
          options: question.options,
        ),
      );
    }

    final score = (correctCount / quiz.totalQuestions * 100).round();
    final passed = score >= quiz.passingScore;

    return QuizResult(
      quizId: quiz.id,
      score: score,
      passed: passed,
      correctAnswers: correctCount,
      wrongAnswers: quiz.totalQuestions - correctCount,
      totalQuestions: quiz.totalQuestions,
      timeUsed: timeUsed,
      questionResults: questionResults,
      completedAt: DateTime.now(),
    );
  }
}
