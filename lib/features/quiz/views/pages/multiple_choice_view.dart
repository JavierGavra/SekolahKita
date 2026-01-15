import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_kita/core/database/static/models/question/multiple_choice_question.dart';
import 'package:sekolah_kita/core/widgets/quiz_snackbar.dart';
import 'package:sekolah_kita/features/quiz/bloc/quiz_bloc.dart';
import 'package:sekolah_kita/features/quiz/cubit/multiple_choice/multiple_choice_cubit.dart';

class MultipleChoiceView extends StatelessWidget {
  const MultipleChoiceView({super.key});

  void _listener(BuildContext context, MultipleChoiceState state) {
    if (state.status == MultipleChoiceStateStatus.answered) {
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

    return BlocConsumer<MultipleChoiceCubit, MultipleChoiceState>(
      listener: _listener,
      builder: (context, state) {
        if (state.status == MultipleChoiceStateStatus.initial) {
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
                    "Pilih 1 jawaban!",
                    style: TextStyle(
                      fontSize: 20,
                      height: 1.4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: color.primaryContainer,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      // Emoji/Icon
                      // if (question.imagePath != null)
                      //   Text(
                      //     question.imagePath!,
                      //     style: const TextStyle(fontSize: 48),
                      //   ),

                      // if (question.imagePath != null)
                      //   const SizedBox(height: 16),
                      Text(
                        question.question,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: color.onPrimaryContainer,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                _buildAnswerGrid(context, question, state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnswerGrid(
    BuildContext context,
    MultipleChoiceQuestion question,
    MultipleChoiceState state,
  ) {
    final color = Theme.of(context).colorScheme;

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
        final isCorrectAnswer = index == question.correctAnswerId;
        final isAnswered = (state.status == MultipleChoiceStateStatus.answered);

        Color getBackgroundColor() {
          if (!isAnswered) {
            return isSelected
                ? color.primaryContainer
                : color.surfaceContainerHigh;
          }

          if (isCorrectAnswer) {
            return Colors.green.shade100;
          }

          if (isSelected && !isCorrectAnswer) {
            return Colors.red.shade100;
          }

          return color.surfaceContainerHigh;
        }

        Color getBorderColor() {
          if (!isAnswered) {
            return isSelected ? color.primary : color.outline;
          }

          if (isCorrectAnswer) {
            return Colors.green;
          }

          if (isSelected && !isCorrectAnswer) {
            return Colors.red;
          }

          return color.outline;
        }

        return GestureDetector(
          onTap: isAnswered
              ? null
              : () => context.read<MultipleChoiceCubit>().selectAnswer(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: getBackgroundColor(),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: getBorderColor()),
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isAnswered && isCorrectAnswer
                          ? Colors.green.shade900
                          : isAnswered && isSelected && !isCorrectAnswer
                          ? Colors.red.shade900
                          : color.onSurface,
                    ),
                  ),
                ),

                // Check/Cross Icon
                if (isAnswered && (isCorrectAnswer || isSelected))
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isCorrectAnswer ? Colors.green : Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isCorrectAnswer ? Icons.check : Icons.close,
                        color: Colors.white,
                        size: 20,
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
}
