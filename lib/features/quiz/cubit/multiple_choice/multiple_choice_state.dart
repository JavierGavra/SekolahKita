part of 'multiple_choice_cubit.dart';

enum MultipleChoiceStateStatus { initial, ready, answered }

final class MultipleChoiceState extends Equatable {
  final MultipleChoiceStateStatus status;
  final MultipleChoiceQuestion? question;
  final int? selectedAnswerId;
  final bool isCorrect;

  const MultipleChoiceState({
    required this.status,
    this.question,
    this.selectedAnswerId,
    required this.isCorrect,
  });

  factory MultipleChoiceState.initial() {
    return const MultipleChoiceState(
      status: MultipleChoiceStateStatus.initial,
      isCorrect: false,
    );
  }

  MultipleChoiceState copyWith({
    MultipleChoiceStateStatus? status,
    MultipleChoiceQuestion? question,
    int? selectedAnswerId,
    bool? isCorrect,
  }) {
    return MultipleChoiceState(
      status: status ?? this.status,
      question: question ?? this.question,
      selectedAnswerId: selectedAnswerId ?? this.selectedAnswerId,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  @override
  List<Object?> get props => [status, selectedAnswerId, question, isCorrect];
}
