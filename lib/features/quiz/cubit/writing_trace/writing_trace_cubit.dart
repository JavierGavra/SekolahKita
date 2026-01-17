import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_kita/core/database/static/models/question/writing_trace_question.dart';

part 'writing_trace_state.dart';

class WritingTraceCubit extends Cubit<WritingTraceState> {
  WritingTraceCubit() : super(WritingTraceState());

  void startQuiz(WritingTraceQuestion question) {
    emit(state.copyWith(status: WritingTraceStatus.ready, question: question));
  }

  void submitAnswer() {
    // 🔜 nanti ganti dengan validasi stroke
    emit(state.copyWith(status: WritingTraceStatus.submitted, isCorrect: true));
  }
}
