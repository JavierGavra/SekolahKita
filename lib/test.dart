// ============================================================
// Dependencies yang diperlukan di pubspec.yaml:
// ============================================================
/*
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.6
  equatable: ^2.0.5
  signature: ^5.5.0  # Untuk drawing/tracing
*/

// ============================================================
// writing_quiz_model.dart
// ============================================================

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WritingQuizModel {
  final int id;
  final String letter;
  final String phonetic;
  final List<StrokeData> strokes;

  WritingQuizModel({
    required this.id,
    required this.letter,
    required this.phonetic,
    required this.strokes,
  });
}

class StrokeData {
  final Offset start;
  final Offset end;
  final StrokeDirection direction;

  StrokeData({required this.start, required this.end, required this.direction});
}

enum StrokeDirection { down, up, left, right, curve }

// ============================================================
// writing_quiz_data.dart - Dummy Data
// ============================================================

class WritingQuizData {
  static List<WritingQuizModel> getQuestions() {
    return [
      // Letter: b
      WritingQuizModel(
        id: 1,
        letter: 'b',
        phonetic: 'be',
        strokes: [
          StrokeData(
            start: Offset(0.3, 0.1),
            end: Offset(0.3, 0.9),
            direction: StrokeDirection.down,
          ),
          StrokeData(
            start: Offset(0.3, 0.5),
            end: Offset(0.7, 0.7),
            direction: StrokeDirection.curve,
          ),
        ],
      ),

      // Letter: M
      WritingQuizModel(
        id: 2,
        letter: 'M',
        phonetic: 'em',
        strokes: [
          StrokeData(
            start: Offset(0.2, 0.9),
            end: Offset(0.2, 0.2),
            direction: StrokeDirection.up,
          ),
          StrokeData(
            start: Offset(0.2, 0.2),
            end: Offset(0.5, 0.6),
            direction: StrokeDirection.down,
          ),
          StrokeData(
            start: Offset(0.5, 0.6),
            end: Offset(0.8, 0.2),
            direction: StrokeDirection.up,
          ),
          StrokeData(
            start: Offset(0.8, 0.2),
            end: Offset(0.8, 0.9),
            direction: StrokeDirection.down,
          ),
        ],
      ),

      // Letter: ч (ch)
      WritingQuizModel(
        id: 3,
        letter: 'ч',
        phonetic: 'che',
        strokes: [
          StrokeData(
            start: Offset(0.25, 0.2),
            end: Offset(0.25, 0.5),
            direction: StrokeDirection.down,
          ),
          StrokeData(
            start: Offset(0.25, 0.5),
            end: Offset(0.5, 0.5),
            direction: StrokeDirection.right,
          ),
          StrokeData(
            start: Offset(0.5, 0.5),
            end: Offset(0.5, 0.9),
            direction: StrokeDirection.down,
          ),
        ],
      ),

      // More letters...
      WritingQuizModel(
        id: 4,
        letter: 'A',
        phonetic: 'a',
        strokes: [
          StrokeData(
            start: Offset(0.5, 0.2),
            end: Offset(0.2, 0.9),
            direction: StrokeDirection.down,
          ),
          StrokeData(
            start: Offset(0.5, 0.2),
            end: Offset(0.8, 0.9),
            direction: StrokeDirection.down,
          ),
          StrokeData(
            start: Offset(0.35, 0.6),
            end: Offset(0.65, 0.6),
            direction: StrokeDirection.right,
          ),
        ],
      ),

      WritingQuizModel(
        id: 5,
        letter: 'O',
        phonetic: 'o',
        strokes: [
          StrokeData(
            start: Offset(0.5, 0.2),
            end: Offset(0.5, 0.2),
            direction: StrokeDirection.curve,
          ),
        ],
      ),
    ];
  }
}

// ============================================================
// writing_quiz_state.dart
// ============================================================

enum WritingQuizStatus {
  initial,
  ready,
  drawing,
  checking,
  correct,
  incorrect,
  completed,
}

final class WritingQuizState extends Equatable {
  final WritingQuizStatus status;
  final List<WritingQuizModel> questions;
  final int currentQuestionIndex;
  final int correctAnswers;
  final List<Offset> drawnPoints;
  final bool isCorrect;

  const WritingQuizState({
    required this.status,
    required this.questions,
    required this.currentQuestionIndex,
    required this.correctAnswers,
    required this.drawnPoints,
    required this.isCorrect,
  });

  factory WritingQuizState.initial() {
    return const WritingQuizState(
      status: WritingQuizStatus.initial,
      questions: [],
      currentQuestionIndex: 0,
      correctAnswers: 0,
      drawnPoints: [],
      isCorrect: false,
    );
  }

  WritingQuizModel get currentQuestion => questions[currentQuestionIndex];
  int get totalQuestions => questions.length;
  int get percentage => (correctAnswers / totalQuestions * 100).round();
  bool get isLastQuestion => currentQuestionIndex >= questions.length - 1;
  double get progress => (currentQuestionIndex + 1) / totalQuestions;

  WritingQuizState copyWith({
    WritingQuizStatus? status,
    List<WritingQuizModel>? questions,
    int? currentQuestionIndex,
    int? correctAnswers,
    List<Offset>? drawnPoints,
    bool? isCorrect,
  }) {
    return WritingQuizState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      drawnPoints: drawnPoints ?? this.drawnPoints,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  @override
  List<Object?> get props => [
    status,
    questions,
    currentQuestionIndex,
    correctAnswers,
    drawnPoints,
    isCorrect,
  ];
}

// ============================================================
// writing_quiz_cubit.dart
// ============================================================

class WritingQuizCubit extends Cubit<WritingQuizState> {
  WritingQuizCubit() : super(WritingQuizState.initial());

  void startQuiz() {
    final questions = WritingQuizData.getQuestions();
    emit(state.copyWith(status: WritingQuizStatus.ready, questions: questions));
  }

  void addPoint(Offset point) {
    if (state.status == WritingQuizStatus.ready ||
        state.status == WritingQuizStatus.drawing) {
      final newPoints = List<Offset>.from(state.drawnPoints)..add(point);
      emit(
        state.copyWith(
          status: WritingQuizStatus.drawing,
          drawnPoints: newPoints,
        ),
      );
    }
  }

  void clearDrawing() {
    emit(state.copyWith(status: WritingQuizStatus.ready, drawnPoints: []));
  }

  void checkAnswer() {
    if (state.drawnPoints.isEmpty) return;

    emit(state.copyWith(status: WritingQuizStatus.checking));

    // Simple check: if user drew something, consider it correct
    // In production, you'd implement proper shape recognition
    final isCorrect = state.drawnPoints.length > 10;

    emit(
      state.copyWith(
        status: isCorrect
            ? WritingQuizStatus.correct
            : WritingQuizStatus.incorrect,
        isCorrect: isCorrect,
      ),
    );
  }

  void nextQuestion() {
    final newCorrectAnswers = state.isCorrect
        ? state.correctAnswers + 1
        : state.correctAnswers;

    if (state.isLastQuestion) {
      emit(
        state.copyWith(
          status: WritingQuizStatus.completed,
          correctAnswers: newCorrectAnswers,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: WritingQuizStatus.ready,
          currentQuestionIndex: state.currentQuestionIndex + 1,
          correctAnswers: newCorrectAnswers,
          drawnPoints: [],
          isCorrect: false,
        ),
      );
    }
  }
}

// ============================================================
// writing_quiz_page.dart
// ============================================================

class WritingQuizPage extends StatelessWidget {
  const WritingQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WritingQuizCubit()..startQuiz(),
      child: const WritingQuizView(),
    );
  }
}

// ============================================================
// writing_quiz_view.dart
// ============================================================

class WritingQuizView extends StatefulWidget {
  const WritingQuizView({super.key});

  @override
  State<WritingQuizView> createState() => _WritingQuizViewState();
}

class _WritingQuizViewState extends State<WritingQuizView>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 0.0,
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

    return BlocListener<WritingQuizCubit, WritingQuizState>(
      listener: (context, state) {
        if (state.status == WritingQuizStatus.correct ||
            state.status == WritingQuizStatus.incorrect) {
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.isCorrect ? '✅ Bagus sekali!' : '❌ Coba lagi!',
                  ),
                  backgroundColor: state.isCorrect
                      ? Colors.green
                      : Colors.orange,
                  duration: const Duration(seconds: 1),
                ),
              );

              Future.delayed(const Duration(seconds: 1), () {
                if (mounted) {
                  context.read<WritingQuizCubit>().nextQuestion();
                }
              });
            }
          });
        }
      },
      child: Scaffold(
        backgroundColor: color.surface,
        body: SafeArea(
          child: BlocBuilder<WritingQuizCubit, WritingQuizState>(
            buildWhen: (previous, current) {
              if (previous.currentQuestionIndex !=
                  current.currentQuestionIndex) {
                _updateProgressAnimation(current);
                return true;
              }

              return previous.status != current.status ||
                  previous.drawnPoints != current.drawnPoints;
            },
            builder: (context, state) {
              if (state.status == WritingQuizStatus.initial) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.status == WritingQuizStatus.completed) {
                return _buildCompletedView(state);
              }

              final currentQuestion = state.currentQuestion;

              return Column(
                children: [
                  // Header
                  _buildHeader(
                    color,
                    state.totalQuestions,
                    state.currentQuestionIndex + 1,
                  ),

                  const SizedBox(height: 24),

                  // Title
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Trace the letter',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Audio button & Letter
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade400,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.volume_up,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentQuestion.letter,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              currentQuestion.phonetic,
                              style: TextStyle(
                                fontSize: 14,
                                color: color.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Drawing Canvas
                  Expanded(
                    child: Center(
                      child: _buildDrawingCanvas(
                        context,
                        currentQuestion,
                        state,
                      ),
                    ),
                  ),

                  // Check Button
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: state.drawnPoints.isEmpty
                            ? null
                            : () {
                                context.read<WritingQuizCubit>().checkAnswer();
                              },
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: color.primary,
                          disabledBackgroundColor: color.surfaceContainerHigh,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'CHECK',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: state.drawnPoints.isEmpty
                                ? color.onSurfaceVariant
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDrawingCanvas(
    BuildContext context,
    WritingQuizModel question,
    WritingQuizState state,
  ) {
    return Container(
      width: 300,
      height: 400,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // Guide lines (cross in center)
          CustomPaint(size: const Size(300, 400), painter: GuideLinesPainter()),

          // Template letter (gray)
          Center(
            child: Text(
              question.letter,
              style: TextStyle(
                fontSize: 200,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),

          // Drawing overlay with gesture detector
          Builder(
            builder: (canvasContext) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onPanStart: (details) {
                  final box = canvasContext.findRenderObject() as RenderBox;
                  final localPoint = box.globalToLocal(details.globalPosition);
                  context.read<WritingQuizCubit>().addPoint(localPoint);
                },
                onPanUpdate: (details) {
                  final box = canvasContext.findRenderObject() as RenderBox;
                  final localPoint = box.globalToLocal(details.globalPosition);
                  context.read<WritingQuizCubit>().addPoint(localPoint);
                },
                child: CustomPaint(
                  size: const Size(300, 400),
                  painter: DrawingPainter(
                    points: state.drawnPoints,
                    isCorrect: state.status == WritingQuizStatus.correct,
                  ),
                ),
              );
            },
          ),

          // Clear button
          if (state.drawnPoints.isNotEmpty)
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                onPressed: () {
                  context.read<WritingQuizCubit>().clearDrawing();
                },
                icon: const Icon(Icons.refresh),
                style: IconButton.styleFrom(backgroundColor: Colors.white),
              ),
            ),

          // Arrow indicator (showing direction)
          if (question.strokes.isNotEmpty && state.drawnPoints.isEmpty)
            _buildStrokeIndicator(question.strokes.first),
        ],
      ),
    );
  }

  Widget _buildStrokeIndicator(StrokeData stroke) {
    return Positioned(
      left: stroke.start.dx * 300,
      top: stroke.start.dy * 400,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue.shade400,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(
          _getDirectionIcon(stroke.direction),
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }

  IconData _getDirectionIcon(StrokeDirection direction) {
    switch (direction) {
      case StrokeDirection.down:
        return Icons.arrow_downward;
      case StrokeDirection.up:
        return Icons.arrow_upward;
      case StrokeDirection.left:
        return Icons.arrow_back;
      case StrokeDirection.right:
        return Icons.arrow_forward;
      case StrokeDirection.curve:
        return Icons.arrow_downward;
    }
  }

  Widget _buildCompletedView(WritingQuizState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🎉', style: TextStyle(fontSize: 80)),
          const SizedBox(height: 16),
          Text(
            'Quiz Selesai!',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Skor: ${state.correctAnswers}/${state.totalQuestions}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }

  void _updateProgressAnimation(WritingQuizState state) {
    final newProgress = (state.currentQuestionIndex + 1) / state.totalQuestions;

    _progressAnimation = Tween<double>(
      begin: _progressAnimation.value,
      end: newProgress,
    ).animate(_progressController);

    _progressController.forward(from: 0);
  }

  Widget _buildHeader(ColorScheme color, int qLength, int currentIndex) {
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
            '$currentIndex/$qLength',
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

// ============================================================
// Custom Painters
// ============================================================

class GuideLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Vertical center line
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      paint,
    );

    // Horizontal center line
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DrawingPainter extends CustomPainter {
  final List<Offset> points;
  final bool isCorrect;

  DrawingPainter({required this.points, required this.isCorrect});

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final paint = Paint()
      ..color = isCorrect ? Colors.green : Colors.blue.shade700
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != Offset.zero && points[i + 1] != Offset.zero) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) {
    return oldDelegate.points != points || oldDelegate.isCorrect != isCorrect;
  }
}
