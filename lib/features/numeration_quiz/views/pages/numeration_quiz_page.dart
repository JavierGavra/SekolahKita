import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_kita/features/numeration_quiz/bloc/quiz_bloc.dart';
import 'package:sekolah_kita/features/numeration_quiz/cubit/multiple_choice_cubit.dart';
import 'package:sekolah_kita/features/numeration_quiz/models/multiple_choice_model.dart';
import 'package:sekolah_kita/features/numeration_quiz/models/quiz_question_model.dart';
import 'package:sekolah_kita/features/numeration_quiz/views/pages/numeration_quiz_view.dart';
import 'package:sekolah_kita/features/reading_quiz/views/widgets/exit_dialog.dart';

class NumerationQuizPage extends StatefulWidget {
  const NumerationQuizPage({super.key});

  @override
  State<NumerationQuizPage> createState() => _NumerationQuizPageState();
}

class _NumerationQuizPageState extends State<NumerationQuizPage>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  void _updateProgressAnimation(QuizState state) {
    final newProgress = (state.currentQuestionIndex + 1) / state.totalQuestions;

    _progressAnimation = Tween<double>(
      begin: _progressAnimation.value,
      end: newProgress,
    ).animate(_progressController);

    _progressController.forward(from: 0);
  }

  void _performPop() async {
    final isExit = await showExitQuizDialog(context);
    if (isExit && mounted) Navigator.of(context).pop();
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

    return BlocProvider(
      create: (context) => QuizBloc()..add(QuizStarted()),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<QuizBloc, QuizState>(
            listener: (context, state) {
              _updateProgressAnimation(state);

              if (state.isLastQuestion &&
                  state.status == QuizStateStatus.completed) {}
            },
            builder: (context, state) {
              if (state.status == QuizStateStatus.initial) {
                return Center(child: CircularProgressIndicator());
              }

              return PopScope(
                canPop: (state.currentQuestionIndex == 0),
                onPopInvokedWithResult: (didPop, result) {
                  if (state.currentQuestionIndex == 0) return;
                  if (didPop) return;
                  _performPop();
                },
                child: Column(
                  children: [
                    _buildHeader(
                      color,
                      state.totalQuestions,
                      state.currentQuestionIndex,
                    ),
                    _buildQuestionView(state.currentQuestion),
                  ],
                ),
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
            onPressed: () {
              if (index == 0) {
                Navigator.pop(context);
                return;
              }
              _performPop();
            },
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

  Widget _buildQuestionView(QuizQuestionModel question) {
    if (question is MultipleChoiceModel) {
      print(question.question);
      return BlocProvider(
        key: ValueKey(question.id),
        create: (context) => MultipleChoiceCubit()..startQuiz(question),
        child: NumerationQuizView(),
      );
    }

    return CircularProgressIndicator();
  }
}
