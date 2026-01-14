import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sekolah_kita/core/database/static/models/question/multiple_choice_question.dart';

part 'multiple_choice_state.dart';

class MultipleChoiceCubit extends Cubit<MultipleChoiceState> {
  MultipleChoiceCubit() : super(MultipleChoiceState.initial());

  void startQuiz(MultipleChoiceQuestion question) {
    emit(
      state.copyWith(
        status: MultipleChoiceStateStatus.ready,
        question: question,
      ),
    );
  }

  // Select answer
  void selectAnswer(int answerId) {
    final isCorrect = (answerId == state.question!.correctAnswerId);

    emit(
      state.copyWith(
        status: MultipleChoiceStateStatus.answered,
        selectedAnswerId: answerId,
        isCorrect: isCorrect,
      ),
    );
  }
}
