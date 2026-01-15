part of 'quiz_bloc.dart';

enum QuizStateStatus { initial, ready, completed, failure }

final class QuizState extends Equatable {
  final QuizStateStatus status;
  final List<QuizQuestionModel> questions;
  final int currentQuestionIndex;
  final int correctAnswers;
  final String? errorMessage;

  const QuizState({
    required this.status,
    required this.questions,
    required this.currentQuestionIndex,
    required this.correctAnswers,
    this.errorMessage,
  });

  factory QuizState.initial() {
    return QuizState(
      status: QuizStateStatus.initial,
      questions: [],
      currentQuestionIndex: 0,
      correctAnswers: 0,
    );
  }

  // Getters
  QuizQuestionModel get currentQuestion => questions[currentQuestionIndex];

  int get totalQuestions => questions.length;

  int get percentage => (correctAnswers / totalQuestions * 100).round();

  bool get isLastQuestion => currentQuestionIndex >= questions.length - 1;

  double get progress => (currentQuestionIndex + 1) / totalQuestions;

  QuizState copyWith({
    QuizStateStatus? status,
    List<QuizQuestionModel>? questions,
    int? currentQuestionIndex,
    int? correctAnswers,
    String? errorMessage,
  }) {
    return QuizState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    questions,
    currentQuestionIndex,
    correctAnswers,
    errorMessage,
  ];
}
