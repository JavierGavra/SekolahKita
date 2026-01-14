import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/quiz_question_model.dart';

class SpeechQuestion extends QuizQuestionModel {
  final String text;
  final String? imagePath;

  SpeechQuestion({required this.text, this.imagePath, required super.id})
    : super(type: QuizQuestionType.speechRecognition);
}
