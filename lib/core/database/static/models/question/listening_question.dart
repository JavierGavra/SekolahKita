import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/quiz_question_model.dart';

/// Tes mendengarkan suara lalu menebak huruf/kata/kalimat apa yang terdengar
class ListeningQuestion extends QuizQuestionModel {
  /// Huryf/Kata/Kalimat yang akan di dengar oleh User
  final String text;

  /// Opsional (tidak teralu penting)
  final String? imagePath;

  /// Pilihan jawaban (4 pilihan)
  final List<String> options;

  /// Index jawaban benar dari array [options]
  final int correctAnswerId;

  ListeningQuestion({
    required super.id,
    required this.text,
    this.imagePath,
    required this.options,
    required this.correctAnswerId,
  }) : super(type: QuizQuestionType.multipleChooice);
}
