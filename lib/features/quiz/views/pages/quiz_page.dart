import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/local_data_persisance.dart';
import 'package:sekolah_kita/core/database/static/models/question/listening_question.dart';
import 'package:sekolah_kita/core/database/static/models/question/multiple_choice_question.dart';
import 'package:sekolah_kita/core/database/static/models/question/multiple_sound_question.dart';
import 'package:sekolah_kita/core/database/static/models/question/speech_question.dart';
import 'package:sekolah_kita/core/database/static/models/question/writing_trace_question.dart';
import 'package:sekolah_kita/core/database/static/models/quiz_question_model.dart';
import 'package:sekolah_kita/features/quiz/bloc/quiz_bloc.dart';
import 'package:sekolah_kita/features/quiz/cubit/listening/listening_cubit.dart';
import 'package:sekolah_kita/features/quiz/cubit/multiple_choice/multiple_choice_cubit.dart';
import 'package:sekolah_kita/features/quiz/cubit/multiple_sound/multiple_sound_cubit.dart';
import 'package:sekolah_kita/features/quiz/cubit/speech/speech_cubit.dart';
import 'package:sekolah_kita/features/quiz/cubit/writing_trace/writing_trace_cubit.dart';
import 'package:sekolah_kita/features/quiz/services/local_service.dart';
import 'package:sekolah_kita/features/quiz/views/pages/listening_view.dart';
import 'package:sekolah_kita/features/quiz/views/pages/multiple_choice_view.dart';
import 'package:sekolah_kita/features/quiz/views/pages/multiple_sound_view.dart';
import 'package:sekolah_kita/features/quiz/views/pages/quiz_result_page.dart';
import 'package:sekolah_kita/features/quiz/views/pages/speech_view.dart';
import 'package:sekolah_kita/features/quiz/views/pages/writing_trace_view.dart';
import 'package:sekolah_kita/features/quiz/views/widgets/exit_dialog.dart';

class QuizPage extends StatefulWidget {
  final int moduleId;
  final CourseType type;

  const QuizPage({super.key, required this.moduleId, required this.type});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
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

  void _whenCompleted(QuizState state) {
    if (state.isLastQuestion && state.status == QuizStateStatus.completed) {
      final localData = LocalDataPersisance();
      if (widget.moduleId > localData.getLastModuleIndex(widget.type)!) {
        localData.setLastModuleIndex(widget.type, widget.moduleId);
      }

      if (state.percentage > 90) {
        LocalService().updateStar(widget.type, widget.moduleId);
      }

      context.pushReplacementTransition(
        curve: Curves.easeInOut,
        type: PageTransitionType.sharedAxisVertical,
        duration: const Duration(milliseconds: 700),
        child: QuizResultPage(
          correctAnswers: state.correctAnswers,
          totalQuestions: state.totalQuestions,
          percentage: state.percentage,
        ),
      );
    }
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
      create: (context) =>
          QuizBloc()..add(QuizStarted(id: widget.moduleId, type: widget.type)),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<QuizBloc, QuizState>(
            listener: (context, state) {
              _updateProgressAnimation(state);
              _whenCompleted(state);
            },
            builder: (context, state) {
              if (state.status == QuizStateStatus.initial) {
                return Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(),
                  ),
                );
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
    if (question is MultipleChoiceQuestion) {
      return BlocProvider(
        key: ValueKey(question.id),
        create: (context) => MultipleChoiceCubit()..startQuiz(question),
        child: MultipleChoiceView(),
      );
    } else if (question is SpeechQuestion) {
      return BlocProvider(
        key: ValueKey(question.id),
        create: (context) => SpeechCubit()..startQuiz(question),
        child: SpeechView(),
      );
    } else if (question is ListeningQuestion) {
      return BlocProvider(
        key: ValueKey(question.id),
        create: (context) => ListeningCubit()..startQuiz(question),
        child: ListeningView(),
      );
    } else if (question is MultipleSoundQuestion) {
      return BlocProvider(
        key: ValueKey(question.id),
        create: (context) => MultipleSoundCubit()..startQuiz(question),
        child: MultipleSoundView(),
      );
    } else if (question is WritingTraceQuestion) {
      return BlocProvider(
        key: ValueKey(question.id),
        create: (_) => WritingTraceCubit()..startQuiz(question),
        child: const WritingTraceView(),
      );
    }

    return Expanded(child: Center(child: CircularProgressIndicator()));
  }
}
