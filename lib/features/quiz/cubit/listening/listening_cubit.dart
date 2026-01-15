import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sekolah_kita/core/database/static/models/question/listening_question.dart';

part 'listening_state.dart';

class ListeningCubit extends Cubit<ListeningState> {
  ListeningCubit() : super(ListeningState.initial());

  void startQuiz(ListeningQuestion question) {
    emit(
      state.copyWith(status: ListeningStateStatus.ready, question: question),
    );
  }

  // Select answer
  void selectAnswer(int answerId) {
    final isCorrect = (answerId == state.question!.correctAnswerId);

    emit(
      state.copyWith(
        status: ListeningStateStatus.answered,
        selectedAnswerId: answerId,
        isCorrect: isCorrect,
      ),
    );
  }
}
