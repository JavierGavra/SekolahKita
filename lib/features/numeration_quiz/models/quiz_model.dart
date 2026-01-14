import 'package:sekolah_kita/features/numeration_quiz/models/quiz_question_model.dart';

class QuizModel {
  final String id;
  final String title;
  final List<QuizQuestionModel> questions;

  const QuizModel({
    required this.id,
    required this.title,
    required this.questions,
  });
}
