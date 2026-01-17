part of 'quiz_bloc.dart';

sealed class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object?> get props => [];
}

final class QuizStarted extends QuizEvent {
  final int id;
  final CourseType type;

  const QuizStarted({required this.id, required this.type});

  @override
  List<Object?> get props => [id, type];
}

final class NextQuestionRequested extends QuizEvent {
  final bool wasCorrect;

  const NextQuestionRequested({required this.wasCorrect});

  @override
  List<Object?> get props => [wasCorrect];
}

final class QuizCompleted extends QuizEvent {
  final int moduleId;
  final CourseType type;

  const QuizCompleted({required this.moduleId, required this.type});

  @override
  List<Object?> get props => [moduleId, type];
}
