import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sekolah_kita/features/reading_quiz/services/speech_service.dart';
import '../models/reading_quiz_model.dart';
import '../services/local_service.dart';

part 'reading_quiz_event.dart';
part 'reading_quiz_state.dart';

class ReadingQuizBloc extends Bloc<ReadingQuizEvent, ReadingQuizState> {
  final _speechService = SpeechService();

  ReadingQuizBloc() : super(ReadingQuizState.initial()) {
    on<ReadingQuizStarted>(_onReadingQuizStarted);
    on<ListeningStarted>(_onListeningStarted);
    on<ListeningStopped>(_onListeningStopped);
    on<NextQuestionRequested>(_onNextQuestionRequested);
  }

  Future<void> _onReadingQuizStarted(
    ReadingQuizStarted event,
    Emitter<ReadingQuizState> emit,
  ) async {
    try {
      await _speechService.initialize();
      final questions = LocalService().getQuestions();

      emit(
        state.copyWith(status: ReadingQuizStatus.ready, questions: questions),
      );
    } catch (e) {
      if (kDebugMode) print(e);
      emit(
        state.copyWith(
          status: ReadingQuizStatus.failure,
          errorMessage: 'Gagal inisialisasi speech recognition',
        ),
      );
    }
  }

  Future<void> _onListeningStarted(
    ListeningStarted event,
    Emitter<ReadingQuizState> emit,
  ) async {
    if (!_speechService.isAvailable) {
      emit(
        state.copyWith(
          status: ReadingQuizStatus.failure,
          errorMessage: "Speech recognition belum tersedia",
        ),
      );
      return;
    }

    emit(
      state.copyWith(status: ReadingQuizStatus.listening, recognizedText: ''),
    );

    try {
      String recognizedText = "";
      await _speechService.startListening(
        onResult: (result) {
          if (kDebugMode) print('mendengarkan... : $result');
          recognizedText = result.toLowerCase();

          if (recognizedText == state.currentQuestion.text.toLowerCase()) {
            add(ListeningStopped(recognizedText: recognizedText));
            return;
          }
        },
      );

      Future.delayed(const Duration(seconds: 5), () {
        if (_speechService.isListening) {
          add(ListeningStopped(recognizedText: recognizedText));
        }
      });
    } catch (e) {
      if (kDebugMode) print(e);
      emit(
        state.copyWith(
          status: ReadingQuizStatus.failure,
          errorMessage: 'Gagal mendengarkan suara',
        ),
      );
    }
  }

  Future<void> _onListeningStopped(
    ListeningStopped event,
    Emitter<ReadingQuizState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ReadingQuizStatus.processing,
        recognizedText: event.recognizedText,
      ),
    );
    await _speechService.stopListening();

    if (event.recognizedText.isEmpty ||
        event.recognizedText != state.currentQuestion.text.toLowerCase()) {
      emit(state.copyWith(status: ReadingQuizStatus.failure));
      return;
    }

    emit(state.copyWith(status: ReadingQuizStatus.answered, isCorrect: true));
  }

  Future<void> _onNextQuestionRequested(
    NextQuestionRequested event,
    Emitter<ReadingQuizState> emit,
  ) async {
    final newCorrectAnswers = (event.wasCorrect)
        ? state.correctAnswers + 1
        : state.correctAnswers;

    if (state.isLastQuestion) {
      emit(
        state.copyWith(
          status: ReadingQuizStatus.completed,
          correctAnswers: newCorrectAnswers,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: ReadingQuizStatus.ready,
          currentQuestionIndex: state.currentQuestionIndex + 1,
          correctAnswers: newCorrectAnswers,
          recognizedText: '',
          isCorrect: false,
        ),
      );
    }
  }
}
