import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/quiz_question_model.dart';

class QuizModel {
  final int id;
  final int moduleId;
  final CourseType course;
  final List<QuizQuestionModel> questions;

  const QuizModel({
    required this.id,
    required this.moduleId,
    required this.course,
    required this.questions,
  });

  int get totalQuestions => questions.length;
}
