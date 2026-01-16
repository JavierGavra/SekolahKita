part of 'lesson_bloc.dart';

enum LessonStateStatus { initial, ready, completed, failure }

final class LessonState extends Equatable {
  final LessonStateStatus status;
  final List<LessonSectionModel> lessonSections;
  final int currentSectionIndex;
  final String? errorMessage;

  const LessonState({
    required this.status,
    required this.lessonSections,
    required this.currentSectionIndex,
    this.errorMessage,
  });

  factory LessonState.initial() {
    return LessonState(
      status: LessonStateStatus.initial,
      lessonSections: [],
      currentSectionIndex: 0,
    );
  }

  // Getters
  LessonSectionModel get currentSection => lessonSections[currentSectionIndex];

  int get totalSection => lessonSections.length;

  bool get isLastSection => currentSectionIndex >= lessonSections.length - 1;

  double get progress => (currentSectionIndex + 1) / totalSection;

  LessonState copyWith({
    LessonStateStatus? status,
    List<LessonSectionModel>? lessonSections,
    int? currentSectionIndex,
    String? errorMessage,
  }) {
    return LessonState(
      status: status ?? this.status,
      lessonSections: lessonSections ?? this.lessonSections,
      currentSectionIndex: currentSectionIndex ?? this.currentSectionIndex,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    lessonSections,
    currentSectionIndex,
    errorMessage,
  ];
}
