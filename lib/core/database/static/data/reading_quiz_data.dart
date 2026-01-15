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
      ],
    ),
  ];
}
