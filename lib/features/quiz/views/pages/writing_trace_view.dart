import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_kita/core/widgets/quiz_snackbar.dart';
import 'package:sekolah_kita/features/quiz/bloc/quiz_bloc.dart';
import 'package:sekolah_kita/features/quiz/cubit/writing_trace/writing_trace_cubit.dart';
import 'package:sekolah_kita/features/quiz/views/widgets/writing_stroke_widget.dart';

class WritingTraceView extends StatelessWidget {
  const WritingTraceView({super.key});

  void _listener(BuildContext context, WritingTraceState state) {
    if (state.status == WritingTraceStatus.submitted) {
      final snackBar = QuizSnackBar(
        onOk: () {},
        correctAnswer: state.question!.target,
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

    return BlocConsumer<WritingTraceCubit, WritingTraceState>(
      listener: _listener,
      builder: (context, state) {
        if (state.status == WritingTraceStatus.initial) {
          return const Expanded(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final question = state.question!;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Ikuti garis untuk menulis",
                  style: TextStyle(
                    fontSize: 20,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),

                /// TARGET CHAR
                Center(
                  child: Text(
                    question.target,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: color.primary,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// TRACING AREA
                Center(
                  child: WritingStrokeWidget(
                    assetPath: 'assets/animations/letter.json',
                    char: question.target,
                  ),
                ),

                const Spacer(),
                // SUBMIT BUTTON
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: state.isSubmitted
                        ? null
                        : () {
                            context.read<WritingTraceCubit>().submitAnswer();
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

                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }
}
