import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/question/multiple_choice_question.dart';
import 'package:sekolah_kita/core/database/static/models/quiz_model.dart';
import 'package:sekolah_kita/core/database/static/models/quiz_question_model.dart';

class NumerationQuizData {
  List<QuizQuestionModel> getQuestion(int moduleId) {
    return _quizData
        .firstWhere((element) => element.moduleId == moduleId)
        .questions;
  }

  final List<QuizModel> _quizData = [
    QuizModel(
      id: 1,
      moduleId: 2,
      course: CourseType.numeration,
      questions: [
        MultipleChoiceQuestion(
          id: 1,
          question: '2 + 3 = ?',
          imagePath: '➕',
          options: ['4', '5', '6', '7'],
          correctAnswerId: 1,
        ),
        MultipleChoiceQuestion(
          id: 3,
          question: 'Ada berapa apel? 🍎🍎🍎🍎🍎',
          imagePath: null,
          options: ['3', '4', '5', '6'],
          correctAnswerId: 2,
        ),
        MultipleChoiceQuestion(
          id: 5,
          question: 'Angka mana yang lebih besar?',
          imagePath: '🔢',
          options: ['7', '5', '3', '9'],
          correctAnswerId: 3,
        ),
      ],
    ),
  ];
}
