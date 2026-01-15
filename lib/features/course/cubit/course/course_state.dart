part of 'course_cubit.dart';

enum CourseStateStatus { loading, success, failure }

final class CourseState extends Equatable {
  final CourseStateStatus status;
  final double overallProgress;
  final double readingProgress;
  final double writingProgress;
  final double numerationProgress;
  final String? errorMessage;

  const CourseState({
    required this.status,
    this.overallProgress = 0,
    this.readingProgress = 0,
    this.writingProgress = 0,
    this.numerationProgress = 0,
    this.errorMessage,
  });

  const CourseState.initial() : this(status: CourseStateStatus.loading);

  CourseState copyWith({
    CourseStateStatus? status,
    double? overallProgress,
    double? readingProgress,
    double? writingProgress,
    double? numerationProgress,
    String? errorMessage,
  }) {
    return CourseState(
      status: status ?? this.status,
      overallProgress: overallProgress ?? this.overallProgress,
      readingProgress: readingProgress ?? this.readingProgress,
      writingProgress: writingProgress ?? this.writingProgress,
      numerationProgress: numerationProgress ?? this.numerationProgress,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    overallProgress,
    readingProgress,
    writingProgress,
    numerationProgress,
    errorMessage,
  ];
}
