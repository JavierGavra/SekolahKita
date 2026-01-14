import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/quiz_question_model.dart';

class MultipleChoiceQuestion extends QuizQuestionModel {
  final String question;
  final String? imagePath;
  final List<String> options;
  final int correctAnswerId;

  MultipleChoiceQuestion({
    required super.id,
    required this.question,
    this.imagePath,
    required this.options,
    required this.correctAnswerId,
  }) : super(type: QuizQuestionType.multipleChooice);
}
