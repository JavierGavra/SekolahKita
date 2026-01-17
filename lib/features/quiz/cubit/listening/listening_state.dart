part of 'listening_cubit.dart';

enum ListeningStateStatus { initial, ready, answered }

final class ListeningState extends Equatable {
  final ListeningStateStatus status;
  final ListeningQuestion? question;
  final int? selectedAnswerId;
  final bool isCorrect;

  const ListeningState({
    required this.status,
    this.question,
    this.selectedAnswerId,
    required this.isCorrect,
  });

  factory ListeningState.initial() {
    return const ListeningState(
      status: ListeningStateStatus.initial,
      isCorrect: false,
    );
  }

  ListeningState copyWith({
    ListeningStateStatus? status,
    ListeningQuestion? question,
    int? selectedAnswerId,
    bool? isCorrect,
  }) {
    return ListeningState(
      status: status ?? this.status,
      question: question ?? this.question,
      selectedAnswerId: selectedAnswerId ?? this.selectedAnswerId,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  @override
  List<Object?> get props => [status, selectedAnswerId, question, isCorrect];
}
