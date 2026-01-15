import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/question/listening_question.dart';
import 'package:sekolah_kita/core/database/static/models/question/speech_question.dart';
import 'package:sekolah_kita/core/database/static/models/quiz_model.dart';
import 'package:sekolah_kita/core/database/static/models/quiz_question_model.dart';

class ReadingQuizData {
  List<QuizQuestionModel> getQuestion(int moduleId) {
    return _quizData
        .firstWhere((element) => element.moduleId == moduleId)
        .questions;
  }

  final List<QuizModel> _quizData = [
    QuizModel(
      id: 1,
      moduleId: 2,
      course: CourseType.reading,
      questions: [
        ListeningQuestion(
          id: 1,
          text: "A",
          options: ['A', 'I', 'U', 'O'],
          correctAnswerId: 0,
        ),
        SpeechQuestion(id: 2, text: "Amba"),
        ListeningQuestion(
          id: 3,
          text: "Ba",
          options: ['Ba', 'Da', 'Sa', 'Ca'],
          correctAnswerId: 0,
        ),
        ListeningQuestion(
          id: 4,
          text: "Sa",
          options: ['Ba', 'Da', 'Sa', 'Ca'],
          correctAnswerId: 2,
        ),
        ListeningQuestion(
          id: 5,
          text: "Rusdi",
          options: ['Rusdi', 'Surdi', 'Ardi', 'Radi'],
          correctAnswerId: 0,
        ),
      ],
    ),
  ];
}
