import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/local_data_persisance.dart';
import 'package:sekolah_kita/core/database/static/models/quiz_question_model.dart';
import '../services/local_service.dart';

// import 'package:sekolah_kita/core/database/static/data/example_quiz_data.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final _localService = LocalService();
  late final int moduleId;
  late final CourseType type;

  QuizBloc() : super(QuizState.initial()) {
    on<QuizStarted>(_onQuizStarted);
    on<NextQuestionRequested>(_onNextQuestionRequested);
  }

  Future<void> _onQuizStarted(
    QuizStarted event,
    Emitter<QuizState> emit,
  ) async {
    try {
      // EXAMPLE QUIZ
      // final questions = ExampleQuizData().getQuestion();
      moduleId = event.id;
      type = event.type;

      final questions = _localService.getQuestions(event.type, event.id);

      emit(state.copyWith(status: QuizStateStatus.ready, questions: questions));
    } catch (e) {
      if (kDebugMode) print(e);
      emit(state.copyWith(status: QuizStateStatus.failure, errorMessage: "$e"));
    }
  }

  Future<void> _onNextQuestionRequested(
    NextQuestionRequested event,
    Emitter<QuizState> emit,
  ) async {
    final newCorrectAnswers = (event.wasCorrect)
        ? state.correctAnswers + 1
        : state.correctAnswers;

    if (state.isLastQuestion) {
      final localData = LocalDataPersisance();
      if (moduleId > localData.getLastModuleIndex(type)!) {
        await localData.setLastModuleIndex(type, moduleId);
      }

      if (state.percentage >= 80) {
        await LocalService().updateStar(type, moduleId);
      }
      emit(
        state.copyWith(
          status: QuizStateStatus.completed,
          correctAnswers: newCorrectAnswers,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: QuizStateStatus.ready,
          currentQuestionIndex: state.currentQuestionIndex + 1,
          correctAnswers: newCorrectAnswers,
          errorMessage: null,
        ),
      );
    }
  }
}
