import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section_model.dart';

class AudioSection extends LessonSectionModel {
  final String text;
  final String textToSpeech;

  const AudioSection({
    required super.id,
    required this.text,
    required this.textToSpeech,
  }) : super(type: LessonSectionType.audio);
}
