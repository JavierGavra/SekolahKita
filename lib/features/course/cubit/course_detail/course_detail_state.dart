part of 'course_detail_cubit.dart';

enum CourseDetailStateStatus { loading, success, failure }

final class CourseDetailState extends Equatable {
  final CourseDetailStateStatus status;
  final double progress;
  final int lastModuleIndex, moduleAmount;
  final List<ModuleModel> modules;
  final String? errorMessage;

  const CourseDetailState({
    required this.status,
    this.progress = 0,
    this.lastModuleIndex = 0,
    this.moduleAmount = 0,
    this.modules = const [],
    this.errorMessage,
  });

  const CourseDetailState.initial()
    : this(status: CourseDetailStateStatus.loading);

  CourseDetailState copyWith({
    CourseDetailStateStatus? status,
    double? progress,
    int? lastModuleIndex,
    int? moduleAmount,
    List<ModuleModel>? modules,
    String? errorMessage,
  }) {
    return CourseDetailState(
      status: status ?? this.status,
      progress: progress ?? this.progress,
      lastModuleIndex: lastModuleIndex ?? this.lastModuleIndex,
      moduleAmount: moduleAmount ?? this.moduleAmount,
      modules: modules ?? this.modules,
      errorMessage: errorMessage ?? errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    progress,
    lastModuleIndex,
    moduleAmount,
    modules,
    errorMessage,
  ];
}
