import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section_model.dart';

class TextSection extends LessonSectionModel {
  final String text;

  const TextSection({required super.id, required this.text})
    : super(type: LessonSectionType.text);
}
