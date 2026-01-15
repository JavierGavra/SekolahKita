part of 'multiple_sound_cubit.dart';

enum MultipleSoundStateStatus { initial, ready, answered }

final class MultipleSoundState extends Equatable {
  final MultipleSoundStateStatus status;
  final MultipleSoundQuestion? question;
  final int? selectedAnswerId;
  final bool isCorrect;

  const MultipleSoundState({
    required this.status,
    this.question,
    this.selectedAnswerId,
    required this.isCorrect,
  });

  factory MultipleSoundState.initial() {
    return const MultipleSoundState(
      status: MultipleSoundStateStatus.initial,
      isCorrect: false,
    );
  }

  MultipleSoundState copyWith({
    MultipleSoundStateStatus? status,
    MultipleSoundQuestion? question,
    int? selectedAnswerId,
    bool? isCorrect,
  }) {
    return MultipleSoundState(
      status: status ?? this.status,
      question: question ?? this.question,
      selectedAnswerId: selectedAnswerId ?? this.selectedAnswerId,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  @override
  List<Object?> get props => [status, selectedAnswerId, question, isCorrect];
}
