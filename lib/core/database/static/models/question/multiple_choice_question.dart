import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/quiz_question_model.dart';

/// Pilihasn ganda sederhana dengan 4 pilihan jawaban
class MultipleChoiceQuestion extends QuizQuestionModel {
  /// Pertanyaan yang akan ditampilkan
  final String question;

  /// Opsional (Tidak terlalu penting)
  final String? imagePath;

  /// Pilihan jawaban (4 pilihan)
  final List<String> options;

  /// Index jawaban benar dari array [options]
  final int correctAnswerId;

  MultipleChoiceQuestion({
    required super.id,
    required this.question,
    this.imagePath,
    required this.options,
    required this.correctAnswerId,
  }) : super(type: QuizQuestionType.multipleChooice);
}
