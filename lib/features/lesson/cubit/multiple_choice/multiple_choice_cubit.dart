import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section/multiple_choice_section.dart';

part 'multiple_choice_state.dart';

class MultipleChoiceCubit extends Cubit<MultipleChoiceState> {
  MultipleChoiceCubit() : super(MultipleChoiceState.initial());

  void startLesson(MultipleChoiceSection section) {
    emit(
      state.copyWith(status: MultipleChoiceStateStatus.ready, section: section),
    );
  }

  // Select answer
  void selectAnswer(int answerId) {
    emit(state.copyWith(selectedAnswerId: answerId));
  }

  // Select answer
  void submitAnswer() {
    final isCorrect =
        (state.selectedAnswerId == state.section!.correctAnswerId);

    emit(
      state.copyWith(
        status: MultipleChoiceStateStatus.answered,
        isCorrect: isCorrect,
      ),
    );
  }
}
