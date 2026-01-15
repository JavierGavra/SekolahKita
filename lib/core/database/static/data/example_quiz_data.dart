import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/question/listening_question.dart';
import 'package:sekolah_kita/core/database/static/models/question/multiple_choice_question.dart';
import 'package:sekolah_kita/core/database/static/models/question/multiple_sound_question.dart';
import 'package:sekolah_kita/core/database/static/models/question/speech_question.dart';
import 'package:sekolah_kita/core/database/static/models/question/writing_trace_question.dart';
import 'package:sekolah_kita/core/database/static/models/quiz_model.dart';
import 'package:sekolah_kita/core/database/static/models/quiz_question_model.dart';

class ExampleQuizData {
  List<QuizQuestionModel> getQuestion() {
    return _quizData.first.questions;
  }

  final List<QuizModel> _quizData = [
    QuizModel(
      /// Di isi sesuai urutan array nya saja (index + 1)
      id: 1,

      /// QuizModel ini diperuntukkan untuk ModulModel.id yang mana (harus
      /// memiliki [ModulType.quiz])
      moduleId: 2,

      /// Quiz ini ada pada Kategori Course apa
      course: CourseType.numeration,

      /// Daftar pertanyaannya (Kalau bisa 1 QuizModel punya 10 pertanyaan)
      /// Berikut adalah contoh cara penggunaan masing-masing tipe pertanyaan
      questions: [
        MultipleChoiceQuestion(
          id: 1,
          question: '2 + 3 = ?',
          imagePath: '➕',
          options: ['4', '5', '6', '7'],
          correctAnswerId: 1,
        ),
        SpeechQuestion(id: 2, text: "Apel", imagePath: "🍎"),
        ListeningQuestion(
          id: 3,
          text: "A",
          options: ['I', 'U', 'A', "O"],
          correctAnswerId: 2,
        ),
        MultipleSoundQuestion(
          id: 4,
          text: 'Saya',
          options: ['saya', 'yaya'],
          correctAnswerId: 0,
        ),
        WritingTraceQuestion(id: 5, target: 'A'),
      ],
    ),
  ];
}
