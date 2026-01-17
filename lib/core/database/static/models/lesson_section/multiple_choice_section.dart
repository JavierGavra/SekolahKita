import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section_model.dart';

/// 2 pilihan jawaban
class MultipleChoiceSection extends LessonSectionModel {
  /// Pertanyaan yang akan ditampilkan
  final String text;

  /// Pilihan jawaban (2 pilihan)
  final List<String> options;

  /// Index jawaban benar dari array [options]
  final int correctAnswerId;

  MultipleChoiceSection({
    required super.id,
    required this.text,
    required this.options,
    required this.correctAnswerId,
  }) : super(type: LessonSectionType.multipleChooice);
}
