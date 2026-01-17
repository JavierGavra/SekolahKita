part of 'writing_trace_cubit.dart';

enum WritingTraceStatus { initial, ready, submitted }

class WritingTraceState {
  final WritingTraceQuestion? question;
  final WritingTraceStatus status;
  final bool isCorrect;

  bool get isSubmitted => status == WritingTraceStatus.submitted;

  WritingTraceState({
    this.question,
    this.status = WritingTraceStatus.initial,
    this.isCorrect = true,
  });

  WritingTraceState copyWith({
    WritingTraceQuestion? question,
    WritingTraceStatus? status,
    bool? isCorrect,
  }) {
    return WritingTraceState(
      question: question ?? this.question,
      status: status ?? this.status,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }
}
