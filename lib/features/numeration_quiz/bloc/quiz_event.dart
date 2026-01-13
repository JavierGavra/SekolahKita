part of 'quiz_bloc.dart';

sealed class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object?> get props => [];
}

final class QuizStarted extends QuizEvent {}

final class NextQuestionRequested extends QuizEvent {
  final bool wasCorrect;

  const NextQuestionRequested({required this.wasCorrect});

  @override
  List<Object?> get props => [wasCorrect];
}

final class QuizCompleted extends QuizEvent {}
