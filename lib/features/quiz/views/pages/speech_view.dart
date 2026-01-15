import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_kita/core/widgets/quiz_snackbar.dart';
import 'package:sekolah_kita/features/quiz/bloc/quiz_bloc.dart';
import 'package:sekolah_kita/features/quiz/cubit/speech/speech_cubit.dart';
import 'package:sekolah_kita/features/quiz/services/tts_service.dart';
import 'package:sekolah_kita/features/quiz/views/widgets/microphone_button.dart';

class SpeechView extends StatelessWidget {
  const SpeechView({super.key});

  void _listener(BuildContext context, SpeechState state) {
    final snackBar = QuizSnackBar(
      onOk: () {},
      correctAnswer: state.question!.text,
    );

    if (state.status == SpeechStateStatus.answered) {
      snackBar.show(
        context,
        type: state.isCorrect
            ? QuizSnackBarType.correct
            : QuizSnackBarType.incorrect,
      );

      Future.delayed(const Duration(seconds: 1), () {
        if (context.mounted) {
          context.read<QuizBloc>().add(
            NextQuestionRequested(wasCorrect: state.isCorrect),
          );
        }
      });
    } else if (state.status == SpeechStateStatus.failure) {
      snackBar.show(
        context,
        currentAnswaer: state.recognizedText,
        type: QuizSnackBarType.almost,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return BlocConsumer<SpeechCubit, SpeechState>(
      listener: _listener,
      builder: (context, state) {
        if (state.status == SpeechStateStatus.initial) {
          return Expanded(child: CircularProgressIndicator());
        }

        final question = state.question!;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentGeometry.topLeft,
                  child: const Text(
                    "Baca kata atau kalimat\ndi bawah ini!",
                    style: TextStyle(
                      fontSize: 20,
                      height: 1.4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: color.primaryContainer,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        question.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: color.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                          height: 1.333,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 2,
                      bottom: 2,
                      child: IconButton.filled(
                        onPressed: () {
                          TtsService().speak(question.text);
                        },
                        color: color.onSurface,
                        style: IconButton.styleFrom(
                          backgroundColor: color.surface,
                        ),
                        icon: Icon(Icons.volume_up_rounded),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                MicrophoneButton(),
                const SizedBox(height: 66),
              ],
            ),
          ),
        );
      },
    );
  }
}
