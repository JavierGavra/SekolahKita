import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/quiz_question_model.dart';

/// Pilihasn ganda menebak suara apa yang harusmya didengar dengan
/// 2 pilihan jawaban
class MultipleSoundQuestion extends QuizQuestionModel {
  /// Pertanyaan yang akan ditampilkan
  final String text;

  /// Opsional (Tidak terlalu penting)
  final String? imagePath;

  /// Pilihan jawaban (2 pilihan)
  final List<String> options;

  /// Index jawaban benar dari array [options]
  final int correctAnswerId;

  MultipleSoundQuestion({
    required super.id,
    required this.text,
    this.imagePath,
    required this.options,
    required this.correctAnswerId,
  }) : super(type: QuizQuestionType.multipleChooice);
}
