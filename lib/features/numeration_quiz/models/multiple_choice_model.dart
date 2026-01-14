import 'package:sekolah_kita/features/numeration_quiz/models/quiz_question_model.dart';

class MultipleChoiceModel extends QuizQuestionModel {
  final String question;
  final String? imagePath;
  final List<AnswerOption> options;
  final String correctAnswerId;

  MultipleChoiceModel({
    required super.id,
    required this.question,
    this.imagePath,
    required this.options,
    required this.correctAnswerId,
  }) : super(type: QuizQuestionType.multipleChooice);

  factory MultipleChoiceModel.fromJson(Map<String, dynamic> json) {
    return MultipleChoiceModel(
      id: json['id'],
      question: json['question'],
      imagePath: json['imageUrl'],
      options: (json['options'] as List)
          .map((o) => AnswerOption.fromJson(o))
          .toList(),
      correctAnswerId: json['correctAnswerId'],
    );
  }
}

class AnswerOption {
  final String id;
  final String text;

  AnswerOption({required this.id, required this.text});

  factory AnswerOption.fromJson(Map<String, dynamic> json) {
    return AnswerOption(id: json['id'], text: json['text']);
  }
}
