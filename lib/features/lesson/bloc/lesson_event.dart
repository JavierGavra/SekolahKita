part of 'lesson_bloc.dart';

sealed class LessonEvent extends Equatable {
  const LessonEvent();

  @override
  List<Object?> get props => [];
}

final class LessonStarted extends LessonEvent {
  final int id;
  final CourseType type;

  const LessonStarted({required this.id, required this.type});

  @override
  List<Object?> get props => [id, type];
}

final class NextSectionRequested extends LessonEvent {
  const NextSectionRequested();

  @override
  List<Object?> get props => [];
}

final class LessonCompleted extends LessonEvent {}
