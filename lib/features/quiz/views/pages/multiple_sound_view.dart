import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_kita/core/database/static/models/question/multiple_sound_question.dart';
import 'package:sekolah_kita/core/widgets/quiz_snackbar.dart';
import 'package:sekolah_kita/features/quiz/bloc/quiz_bloc.dart';
import 'package:sekolah_kita/features/quiz/cubit/multiple_sound/multiple_sound_cubit.dart';
import 'package:sekolah_kita/features/quiz/services/tts_service.dart';

class MultipleSoundView extends StatelessWidget {
  const MultipleSoundView({super.key});

  void _listener(BuildContext context, MultipleSoundState state) {
    if (state.status == MultipleSoundStateStatus.answered) {
      final snackBar = QuizSnackBar(
        onOk: () {},
        correctAnswer: state.question!.options[state.question!.correctAnswerId],
      );

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
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return BlocConsumer<MultipleSoundCubit, MultipleSoundState>(
      listener: _listener,
      builder: (context, state) {
        if (state.status == MultipleSoundStateStatus.initial) {
          return const Expanded(child: CircularProgressIndicator());
        }

        final question = state.question!;
        final isAnswered = state.status == MultipleSoundStateStatus.answered;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Pilih 1 jawaban!",
                    style: TextStyle(
                      fontSize: 20,
                      height: 1.4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Question Box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: color.primaryContainer,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    question.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: color.onPrimaryContainer,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                _buildAnswerGrid(context, question, state),

                const SizedBox(height: 32),

                // SUBMIT BUTTON
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: (state.selectedAnswerId == null || isAnswered)
                        ? null
                        : () {
                            context.read<MultipleSoundCubit>().submitAnswer();
                          },
                    child: const Text(
                      "SUBMIT",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnswerGrid(
    BuildContext context,
    MultipleSoundQuestion question,
    MultipleSoundState state,
  ) {
    final color = Theme.of(context).colorScheme;
    final isAnswered = state.status == MultipleSoundStateStatus.answered;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: question.options.length,
      itemBuilder: (context, index) {
        final option = question.options[index];
        final isSelected = state.selectedAnswerId == index;
        final isCorrect = index == question.correctAnswerId;

        Color bgColor() {
          if (!isAnswered) {
            return isSelected
                ? color.tertiaryContainer
                : color.surfaceContainerHigh;
          }
          if (isCorrect) return Colors.green.shade100;
          if (isSelected && !isCorrect) return Colors.red.shade100;
          return color.surfaceContainerHigh;
        }

        Color borderColor() {
          if (!isAnswered) {
            return isSelected ? color.primary : color.outline;
          }
          if (isCorrect) return Colors.green;
          if (isSelected && !isCorrect) return Colors.red;
          return color.outline;
        }

        return GestureDetector(
          onTap: isAnswered
              ? null
              : () {
                  TtsService()
                    ..useIndonesianMale()
                    ..speak(option);
                  context.read<MultipleSoundCubit>().selectAnswer(index);
                },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            decoration: BoxDecoration(
              color: bgColor(),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor()),
            ),
            child: Center(child: Icon(Icons.volume_up_rounded, size: 34)),
          ),
        );
      },
    );
  }
}
