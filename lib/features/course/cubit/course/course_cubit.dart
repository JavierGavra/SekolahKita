import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/features/course/services/local_service.dart';

part 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  final _localService = LocalService();

  CourseCubit() : super(CourseState.initial());

  void loadData() async {
    emit(state.copyWith(status: CourseStateStatus.loading));

    final overallProgress = _localService.getOverallProgress();
    final readingProgress = _localService.getCourseProgress(CourseType.reading);
    final writingProgress = _localService.getCourseProgress(CourseType.writing);
    final numerationProgress = _localService.getCourseProgress(
      CourseType.numeration,
    );

    final readingStar = await LocalService().getStarsByCourse(
      CourseType.reading,
    );
    final writingStar = await LocalService().getStarsByCourse(
      CourseType.writing,
    );
    final numerationStar = await LocalService().getStarsByCourse(
      CourseType.numeration,
    );

    emit(
      state.copyWith(
        status: CourseStateStatus.success,
        overallProgress: overallProgress,
        readingProgress: readingProgress,
        writingProgress: writingProgress,
        readingStar: readingStar,
        writingStar: writingStar,
        numerationsStar: numerationStar,
        numerationProgress: numerationProgress,
      ),
    );
  }
}
