import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sekolah_kita/features/numeration_quiz/models/multiple_choice_model.dart';

part 'multiple_choice_state.dart';

class MultipleChoiceCubit extends Cubit<MultipleChoiceState> {
  MultipleChoiceCubit() : super(MultipleChoiceState.initial());

  void startQuiz(MultipleChoiceModel question) {
    emit(
      state.copyWith(
        status: MultipleChoiceStateStatus.ready,
        question: question,
      ),
    );
  }

  // Select answer
  void selectAnswer(String answerId) {
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
