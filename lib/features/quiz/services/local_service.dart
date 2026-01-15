import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/data/numeration_quiz_data.dart';
import 'package:sekolah_kita/core/database/static/models/question/multiple_choice_question.dart';
import 'package:sekolah_kita/core/database/static/models/question/speech_question.dart';
import 'package:sekolah_kita/core/database/static/models/quiz_question_model.dart';

class LocalService {
  List<QuizQuestionModel> getQuestions(CourseType type, int moduleId) {
    if (type == CourseType.numeration) {
      return NumerationQuizData().getQuestion(moduleId);
    } else {
      return [
        SpeechQuestion(text: "Buku", id: 1),
        MultipleChoiceQuestion(
          id: 2,
          question: "🍎",
          options: ['Apel', 'Pir', "Leci", 'Semangka'],
          correctAnswerId: 0,
        ),
        SpeechQuestion(text: "Ngawi", id: 3),
      ];
    }
  }
}
