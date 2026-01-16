part of 'course_cubit.dart';

enum CourseStateStatus { loading, success, failure }

final class CourseState extends Equatable {
  final CourseStateStatus status;
  final double overallProgress;
  final double readingProgress;
  final double writingProgress;
  final double numerationProgress;
  final int readingStar;
  final int writingStar;
  final int numerationsStar;
  final String? errorMessage;

  const CourseState({
    required this.status,
    this.overallProgress = 0,
    this.readingProgress = 0,
    this.writingProgress = 0,
    this.numerationProgress = 0,
    this.readingStar = 0,
    this.writingStar = 0,
    this.numerationsStar = 0,
    this.errorMessage,
  });

  const CourseState.initial() : this(status: CourseStateStatus.loading);

  CourseState copyWith({
    CourseStateStatus? status,
    double? overallProgress,
    double? readingProgress,
    double? writingProgress,
    double? numerationProgress,
    int? readingStar,
    int? writingStar,
    int? numerationsStar,
    String? errorMessage,
  }) {
    return CourseState(
      status: status ?? this.status,
      overallProgress: overallProgress ?? this.overallProgress,
      readingProgress: readingProgress ?? this.readingProgress,
      writingProgress: writingProgress ?? this.writingProgress,
      numerationProgress: numerationProgress ?? this.numerationProgress,
      readingStar: readingStar ?? this.readingStar,
      writingStar: writingStar ?? this.writingStar,
      numerationsStar: numerationsStar ?? this.numerationsStar,
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
    readingStar,
    writingStar,
    numerationsStar,
    errorMessage,
  ];
}
