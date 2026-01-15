import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/quiz_question_model.dart';

/// Quiz menulis dengan tracing (mengikuti pola)
class WritingTraceQuestion extends QuizQuestionModel {
  /// Huruf / Kata / Angka yang harus ditulis
  final String target;

  /// Path SVG / JSON stroke (recommended)
  // final String strokeAssetPath;

  // /// Jumlah minimal stroke valid
  // final int minStroke;

  // /// Toleransi deviasi (0.0 - 1.0)
  // final double tolerance;

  WritingTraceQuestion({
    required super.id,
    required this.target,
    // required this.strokeAssetPath,
    // this.minStroke = 1,
    // this.tolerance = 0.35,
  }) : super(type: QuizQuestionType.writingTrace);
}
