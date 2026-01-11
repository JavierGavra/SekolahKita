import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_kita/core/widgets/quiz_snackbar.dart';
import 'package:sekolah_kita/features/reading_quiz/bloc/reading_quiz_bloc.dart';
import 'package:sekolah_kita/features/reading_quiz/views/widgets/microphone_button.dart';

class ReadingQuizView extends StatefulWidget {
  const ReadingQuizView({super.key});

  @override
  State<ReadingQuizView> createState() => _ReadingQuizViewState();
}

class _ReadingQuizViewState extends State<ReadingQuizView>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  void _updateProgressAnimation(ReadingQuizState state) {
    final newProgress = (state.currentQuestionIndex + 1) / state.totalQuestions;

    _progressAnimation = Tween<double>(
      begin: _progressAnimation.value,
      end: newProgress,
    ).animate(_progressController);

    _progressController.forward(from: 0);
  }

  void _nextQuestion(bool wasCorrect) async {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.read<ReadingQuizBloc>().add(
          NextQuestionRequested(wasCorrect: wasCorrect),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 0.00,
    ).animate(_progressController);
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    int trial = 1;

    return BlocListener<ReadingQuizBloc, ReadingQuizState>(
      listener: (context, state) {
        final snackBar = QuizSnackBar(
          onOk: () {},
          correctAnswer: state.currentQuestion.text,
        );

        if (state.status == ReadingQuizStatus.ready) {
          setState(() => _updateProgressAnimation(state));
        } else if (state.status == ReadingQuizStatus.answered) {
          snackBar.show(context, type: QuizSnackBarType.correct);
          _nextQuestion(true);
        } else if (state.status == ReadingQuizStatus.failure) {
          if (trial >= 3) {
            snackBar.show(context, type: QuizSnackBarType.incorrect);
            _nextQuestion(false);
            return;
          }

          snackBar.show(
            context,
            currentAnswaer: state.recognizedText,
            type: QuizSnackBarType.almost,
          );
          trial++;
        }
      },
      child: Scaffold(
        backgroundColor: color.surface,
        body: SafeArea(
          child: BlocBuilder<ReadingQuizBloc, ReadingQuizState>(
            buildWhen: (previous, current) {
              return previous.status != ReadingQuizStatus.ready &&
                  (current.status == ReadingQuizStatus.ready);
            },
            builder: (context, state) {
              if (state.status == ReadingQuizStatus.initial) {
                return Center(child: CircularProgressIndicator());
              }

              final currentQuestion = state.currentQuestion;
              return Column(
                children: [
                  _buildHeader(
                    color,
                    state.totalQuestions,
                    state.currentQuestionIndex,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Baca kata atau kalimat\ndi bawah ini!",
                          style: TextStyle(
                            fontSize: 20,
                            height: 1.4,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color.surfaceContainerHighest,
                            border: Border.all(
                              width: 3,
                              color: currentQuestion.difficultyColor,
                            ),
                          ),
                          child: Text(
                            currentQuestion.difficultyEmoji,
                            style: TextStyle(
                              color: color.onPrimary,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(32),
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: color.primaryContainer,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      currentQuestion.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: color.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                        height: 1.333,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  MicrophoneButton(),
                  const SizedBox(height: 66),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme color, int qLength, int index) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
            color: color.onSurfaceVariant,
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: _progressAnimation.value,
                    minHeight: 12,
                    backgroundColor: color.surfaceContainerHigh,
                    valueColor: AlwaysStoppedAnimation<Color>(color.primary),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Text(
            '${index + 1}/$qLength',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
