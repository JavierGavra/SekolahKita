import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/local_data_persisance.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section/draw_letter_section.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section/audio_section.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section/multiple_choice_section.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section/text_section.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section_model.dart';
import 'package:sekolah_kita/core/utils/study_time/study_time_session.dart';
import 'package:sekolah_kita/features/lesson/bloc/lesson_bloc.dart';
import 'package:sekolah_kita/features/lesson/cubit/multiple_choice/multiple_choice_cubit.dart';
import 'package:sekolah_kita/features/lesson/views/pages/draw_letter_section_view.dart';
import 'package:sekolah_kita/features/lesson/views/pages/audio_section_view.dart';
import 'package:sekolah_kita/features/lesson/views/pages/lesson_result_page.dart';
import 'package:sekolah_kita/features/lesson/views/pages/multiple_choice_view.dart';
import 'package:sekolah_kita/features/lesson/views/pages/text_section_view.dart';
import 'package:sekolah_kita/features/lesson/views/widgets/exit_dialog.dart';

class LessonPage extends StatefulWidget {
  final int moduleId;
  final CourseType type;

  const LessonPage({super.key, required this.moduleId, required this.type});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> with TickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  void _updateProgressAnimation(LessonState state) {
    final newProgress = (state.currentSectionIndex + 1) / state.totalSection;

    _progressAnimation = Tween<double>(
      begin: _progressAnimation.value,
      end: newProgress,
    ).animate(_progressController);

    _progressController.forward(from: 0);
  }

  void _whenCompleted(LessonState state) {
    if (state.status == LessonStateStatus.completed) {
      final localData = LocalDataPersisance();
      if (widget.moduleId > localData.getLastModuleIndex(widget.type)!) {
        localData.setLastModuleIndex(widget.type, widget.moduleId);
      }

      context.pushReplacementTransition(
        curve: Curves.easeInOut,
        type: PageTransitionType.sharedAxisVertical,
        duration: const Duration(milliseconds: 700),
        child: LessonResultPage(),
      );
    }
  }

  void _performPop() async {
    final isExit = await showExitLessonDialog(context);
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
    StudyTimeSession.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (context) =>
          LessonBloc()
            ..add(LessonStarted(id: widget.moduleId, type: widget.type)),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<LessonBloc, LessonState>(
            listener: (context, state) {
              _updateProgressAnimation(state);
              _whenCompleted(state);
            },
            buildWhen: (previous, current) =>
                !(previous.status == LessonStateStatus.ready &&
                    current.status == LessonStateStatus.completed),
            builder: (context, state) {
              if (state.status == LessonStateStatus.initial) {
                return Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return PopScope(
                canPop: (state.currentSectionIndex == 0),
                onPopInvokedWithResult: (didPop, result) {
                  if (state.currentSectionIndex == 0) return;
                  if (didPop) return;
                  _performPop();
                },
                child: Column(
                  children: [
                    _buildHeader(
                      color,
                      state.totalSection,
                      state.currentSectionIndex,
                    ),
                    _buildSectionView(state.currentSection),
                    _buildNextButton(context, color, state.isLastSection),
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
        ],
      ),
    );
  }

  Widget _buildSectionView(LessonSectionModel section) {
    if (section is TextSection) {
      return TextSectionView(key: ValueKey(section.id), section: section);
    } else if (section is AudioSection) {
      return AudioSectionView(key: ValueKey(section.id), section: section);
    } else if (section is DrawLetterSection) {
      return DrawLetterSectionView(key: ValueKey(section.id), section: section);
    } else if (section is MultipleChoiceSection) {
      return BlocProvider(
        key: ValueKey(section.id),
        create: (context) => MultipleChoiceCubit()..startLesson(section),
        child: MultipleChoiceView(),
      );
    }

    return Expanded(child: Center(child: CircularProgressIndicator()));
  }

  Widget _buildNextButton(
    BuildContext context,
    ColorScheme color,
    bool isLastSection,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              context.read<LessonBloc>().add(
                NextSectionRequested(),
                // state.isLastSection
                //     ? LessonCompleted()
                //     : NextSectionRequested(),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: color.primary,
              foregroundColor: color.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              isLastSection ? "Selesai" : 'Selanjutnya',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
