import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/quiz_question_model.dart';

/// Tes lisan hanya untuk kata atau kalimat, tidak bisa 1 huruf
class SpeechQuestion extends QuizQuestionModel {
  /// Kata yang di tes kan
  final String text;

  /// Opsional (tidak terlalu penting)
  final String? imagePath;

  SpeechQuestion({required super.id, required this.text, this.imagePath})
    : super(type: QuizQuestionType.speechRecognition);
}
