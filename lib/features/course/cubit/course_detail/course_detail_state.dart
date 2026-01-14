part of 'course_detail_cubit.dart';

sealed class CourseDetailState extends Equatable {
  const CourseDetailState();

  @override
  List<Object> get props => [];
}

final class CourseDetailInitial extends CourseDetailState {}
