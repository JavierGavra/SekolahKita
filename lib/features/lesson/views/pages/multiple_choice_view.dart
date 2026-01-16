import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section/multiple_choice_section.dart';
import 'package:sekolah_kita/core/widgets/quiz_snackbar.dart';
import 'package:sekolah_kita/features/lesson/cubit/multiple_choice/multiple_choice_cubit.dart';

class MultipleChoiceView extends StatelessWidget {
  const MultipleChoiceView({super.key});

  void _listener(BuildContext context, MultipleChoiceState state) {
    if (state.status == MultipleChoiceStateStatus.answered) {
      final snackBar = QuizSnackBar(
        onOk: () {},
        correctAnswer: state.section!.options[state.section!.correctAnswerId],
      );

      snackBar.show(
        context,
        type: state.isCorrect
            ? QuizSnackBarType.correct
            : QuizSnackBarType.incorrect,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return BlocConsumer<MultipleChoiceCubit, MultipleChoiceState>(
      listener: _listener,
      builder: (context, state) {
        if (state.status == MultipleChoiceStateStatus.initial) {
          return const Expanded(child: CircularProgressIndicator());
        }

        final section = state.section!;
        final isAnswered = state.status == MultipleChoiceStateStatus.answered;

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
                    section.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: color.onPrimaryContainer,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                _buildAnswerGrid(context, section, state),

                const SizedBox(height: 32),

                // SUBMIT BUTTON
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: (state.selectedAnswerId == null || isAnswered)
                        ? null
                        : () {
                            context.read<MultipleChoiceCubit>().submitAnswer();
                          },
                    child: const Text(
                      "SUBMIT",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
    MultipleChoiceSection section,
    MultipleChoiceState state,
  ) {
    final color = Theme.of(context).colorScheme;
    final isAnswered = state.status == MultipleChoiceStateStatus.answered;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: section.options.length,
      itemBuilder: (context, index) {
        final option = section.options[index];
        final isSelected = state.selectedAnswerId == index;
        final isCorrect = index == section.correctAnswerId;

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
              : () => context.read<MultipleChoiceCubit>().selectAnswer(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            decoration: BoxDecoration(
              color: bgColor(),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor()),
            ),
            child: Center(
              child: Text(
                option,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}
