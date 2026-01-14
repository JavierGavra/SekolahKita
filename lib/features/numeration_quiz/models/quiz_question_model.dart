enum QuizQuestionType { speechRecognition, multipleChooice, textField }

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
    };
  }
}
