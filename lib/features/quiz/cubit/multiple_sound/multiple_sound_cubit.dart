import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sekolah_kita/core/database/static/models/question/multiple_sound_question.dart';

part 'multiple_sound_state.dart';

class MultipleSoundCubit extends Cubit<MultipleSoundState> {
  MultipleSoundCubit() : super(MultipleSoundState.initial());

  void startQuiz(MultipleSoundQuestion question) {
    emit(
      state.copyWith(
        status: MultipleSoundStateStatus.ready,
        question: question,
      ),
    );
  }

  // Select answer
  void selectAnswer(int answerId) {
    emit(state.copyWith(selectedAnswerId: answerId));
  }

  // Select answer
  void submitAnswer() {
    final isCorrect =
        (state.selectedAnswerId == state.question!.correctAnswerId);

    emit(
      state.copyWith(
        status: MultipleSoundStateStatus.answered,
        isCorrect: isCorrect,
      ),
    );
  }
}
