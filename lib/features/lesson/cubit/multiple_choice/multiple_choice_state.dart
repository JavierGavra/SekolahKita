part of 'multiple_choice_cubit.dart';

enum MultipleChoiceStateStatus { initial, ready, answered }

final class MultipleChoiceState extends Equatable {
  final MultipleChoiceStateStatus status;
  final MultipleChoiceSection? section;
  final int? selectedAnswerId;
  final bool isCorrect;

  const MultipleChoiceState({
    required this.status,
    this.section,
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
    MultipleChoiceSection? section,
    int? selectedAnswerId,
    bool? isCorrect,
  }) {
    return MultipleChoiceState(
      status: status ?? this.status,
      section: section ?? this.section,
      selectedAnswerId: selectedAnswerId ?? this.selectedAnswerId,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  @override
  List<Object?> get props => [status, selectedAnswerId, section, isCorrect];
}
