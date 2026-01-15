import 'package:sekolah_kita/core/constant/enum.dart';

abstract class QuizQuestionModel {
  final int id;
  final QuizQuestionType type;

  const QuizQuestionModel({required this.id, required this.type});

  String get description {
    return switch (type) {
      QuizQuestionType.speechRecognition =>
        "Baca kata atau kalimat\ndi bawah ini!",
      QuizQuestionType.multipleChooice => "Pilih 1 jawaban!",
      QuizQuestionType.textField => "Isi kotak di bawah!",
      QuizQuestionType.listening => "Kata atau Kalimat apa\nyang terdegar?",
      QuizQuestionType.multipleSound => "Pilih suara yang cocok!",
      QuizQuestionType.writingTrace => "Gambar sesuai pola",
    };
  }
}
