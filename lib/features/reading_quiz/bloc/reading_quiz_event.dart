part of 'reading_quiz_bloc.dart';

sealed class ReadingQuizEvent extends Equatable {
  const ReadingQuizEvent();

  @override
  List<Object?> get props => [];
}

final class ReadingQuizStarted extends ReadingQuizEvent {
  const ReadingQuizStarted();
}

final class ListeningStarted extends ReadingQuizEvent {
  const ListeningStarted();
}

final class ListeningStopped extends ReadingQuizEvent {
  final String recognizedText;

  const ListeningStopped({required this.recognizedText});

  @override
  List<Object?> get props => [recognizedText];
}

final class NextQuestionRequested extends ReadingQuizEvent {
  final bool wasCorrect;

  const NextQuestionRequested({required this.wasCorrect});

  @override
  List<Object?> get props => [wasCorrect];
}

final class QuizCompleted extends ReadingQuizEvent {
  const QuizCompleted();
}
