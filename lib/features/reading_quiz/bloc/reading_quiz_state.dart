part of 'reading_quiz_bloc.dart';

enum ReadingQuizStatus {
  initial,
  ready,
  listening,
  processing,
  answered,
  completed,
  failure,
}

final class ReadingQuizState extends Equatable {
  final ReadingQuizStatus status;
  final List<ReadingQuizModel> questions;
  final int currentQuestionIndex;
  final int correctAnswers;
  final String recognizedText;
  final bool isCorrect;
  final String? errorMessage;

  const ReadingQuizState({
    required this.status,
    required this.questions,
    required this.currentQuestionIndex,
    required this.correctAnswers,
    required this.recognizedText,
    required this.isCorrect,
    this.errorMessage,
  });

  factory ReadingQuizState.initial() {
    return ReadingQuizState(
      status: ReadingQuizStatus.initial,
      questions: [],
      currentQuestionIndex: 0,
      correctAnswers: 0,
      recognizedText: '',
      isCorrect: false,
    );
  }

  // Getters
  ReadingQuizModel get currentQuestion => questions[currentQuestionIndex];

  int get totalQuestions => questions.length;

  int get percentage => (correctAnswers / totalQuestions * 100).round();

  bool get isLastQuestion => currentQuestionIndex >= questions.length - 1;

  double get progress => (currentQuestionIndex + 1) / totalQuestions;

  ReadingQuizState copyWith({
    ReadingQuizStatus? status,
    List<ReadingQuizModel>? questions,
    int? currentQuestionIndex,
    int? correctAnswers,
    String? recognizedText,
    bool? isCorrect,
    String? errorMessage,
  }) {
    return ReadingQuizState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      recognizedText: recognizedText ?? this.recognizedText,
      isCorrect: isCorrect ?? this.isCorrect,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    questions,
    currentQuestionIndex,
    correctAnswers,
    recognizedText,
    isCorrect,
    errorMessage,
  ];
}
