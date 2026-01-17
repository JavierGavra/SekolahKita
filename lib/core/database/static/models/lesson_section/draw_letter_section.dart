import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section_model.dart';

class DrawLetterSection extends LessonSectionModel {
  final String text;
  final String char;

  DrawLetterSection({required super.id, required this.text, required this.char})
    : super(type: LessonSectionType.drawLetter);
}
