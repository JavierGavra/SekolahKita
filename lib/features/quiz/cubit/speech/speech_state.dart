part of 'speech_cubit.dart';

enum SpeechStateStatus {
  initial,
  ready,
  listening,
  processing,
  answered,
  failure,
}

final class SpeechState extends Equatable {
  final SpeechStateStatus status;
  final SpeechQuestion? question;
  final int? selectedAnswerId;
  final bool isCorrect;
  final String recognizedText;
  final int trial;
  final String? errorMessage;

  const SpeechState({
    required this.status,
    this.question,
    this.selectedAnswerId,
    required this.isCorrect,
    this.recognizedText = "",
    this.trial = 0,
    this.errorMessage,
  });

  factory SpeechState.initial() {
    return const SpeechState(
      status: SpeechStateStatus.initial,
      isCorrect: false,
    );
  }

  SpeechState copyWith({
    SpeechStateStatus? status,
    SpeechQuestion? question,
    int? selectedAnswerId,
    bool? isCorrect,
    String? recognizedText,
    int? trial,
    String? errorMessage,
  }) {
    return SpeechState(
      status: status ?? this.status,
      question: question ?? this.question,
      selectedAnswerId: selectedAnswerId ?? this.selectedAnswerId,
      isCorrect: isCorrect ?? this.isCorrect,
      recognizedText: recognizedText ?? this.recognizedText,
      trial: trial ?? this.trial,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedAnswerId,
    question,
    isCorrect,
    recognizedText,
    trial,
    errorMessage,
  ];
}
