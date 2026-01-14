import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sekolah_kita/core/database/static/models/question/speech_question.dart';
import 'package:sekolah_kita/features/quiz/services/speech_service.dart';

part 'speech_state.dart';

class SpeechCubit extends Cubit<SpeechState> {
  final _speechService = SpeechService();

  SpeechCubit() : super(SpeechState.initial());

  void startQuiz(SpeechQuestion question) async {
    await _speechService.initialize();
    emit(state.copyWith(status: SpeechStateStatus.ready, question: question));
  }

  void listeningStarted() async {
    if (!_speechService.isAvailable) {
      emit(
        state.copyWith(
          status: SpeechStateStatus.failure,
          errorMessage: "Speech recognition belum tersedia",
        ),
      );
      return;
    }

    emit(
      state.copyWith(status: SpeechStateStatus.listening, recognizedText: ''),
    );

    try {
      String recognizedText = "";
      await _speechService.startListening(
        onResult: (result) {
          if (kDebugMode) print('mendengarkan... : $result');
          recognizedText = result.toLowerCase();

          if (recognizedText == state.question!.text) {
            listeningStopped(recognizedText);
            return;
          }
        },
      );

      Future.delayed(const Duration(seconds: 5), () {
        if (_speechService.isListening) listeningStopped(recognizedText);
      });
    } catch (e) {
      if (kDebugMode) print(e);
      emit(
        state.copyWith(
          status: SpeechStateStatus.failure,
          errorMessage: 'Gagal mendengarkan suara',
        ),
      );
    }
  }

  void listeningStopped(String recognizedText) async {
    emit(
      state.copyWith(
        status: SpeechStateStatus.processing,
        recognizedText: recognizedText,
        trial: state.trial + 1,
      ),
    );
    await _speechService.stopListening();

    if (recognizedText.isEmpty ||
        recognizedText != state.question!.text.toLowerCase()) {
      if (state.trial == 3) {
        emit(
          state.copyWith(status: SpeechStateStatus.answered, isCorrect: false),
        );
      } else {
        emit(state.copyWith(status: SpeechStateStatus.failure));
      }

      return;
    }

    emit(state.copyWith(status: SpeechStateStatus.answered, isCorrect: true));
  }
}
