import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/local_data_persisance.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section_model.dart';
import 'package:sekolah_kita/core/utils/study_time/study_time_session.dart';
import 'package:sekolah_kita/features/lesson/services/local_service.dart';

// import 'package:sekolah_kita/core/database/static/data/example_lesson_data.dart';

part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final _localService = LocalService();

  LessonBloc() : super(LessonState.initial()) {
    on<LessonStarted>(_onLesssonStarted);
    on<NextSectionRequested>(_onNextSectionRequested);
  }

  Future<void> _onLesssonStarted(
    LessonStarted event,
    Emitter<LessonState> emit,
  ) async {
    try {
      // EXAMPLE QUIZ
      // final sections = ExampleLessonData().getLessonSection();

      final sections = _localService.getSections(event.type, event.id);

      StudyTimeSession.start();
      emit(
        state.copyWith(
          status: LessonStateStatus.ready,
          lessonSections: sections,
        ),
      );
    } catch (e) {
      if (kDebugMode) print(e);
      emit(
        state.copyWith(status: LessonStateStatus.failure, errorMessage: "$e"),
      );
    }
  }

  Future<void> _onNextSectionRequested(
    NextSectionRequested event,
    Emitter<LessonState> emit,
  ) async {
    if (state.isLastSection) {
      final localData = LocalDataPersisance();

      final seconds = StudyTimeSession.finish();
      await localData.addSeconds(seconds);

      emit(state.copyWith(status: LessonStateStatus.completed));
    } else {
      emit(
        state.copyWith(
          status: LessonStateStatus.ready,
          currentSectionIndex: state.currentSectionIndex + 1,
          errorMessage: null,
        ),
      );
    }
  }
}
