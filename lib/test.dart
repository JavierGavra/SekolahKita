import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_kita/core/widgets/quiz_snackbar.dart';
import 'package:sekolah_kita/features/quiz/bloc/quiz_bloc.dart';

/// =======================
/// MODEL QUESTION (MINIMAL)
/// =======================
class WritingTraceQuestion {
  final int id;
  final String target; // Huruf / Angka / Kata
  final int minStroke;

  const WritingTraceQuestion({
    required this.id,
    required this.target,
    this.minStroke = 1,
  });
}

/// =======================
/// STATE
/// =======================
enum WritingTraceStatus { initial, ready, answered }

class WritingTraceState {
  final WritingTraceStatus status;
  final WritingTraceQuestion? question;
  final List<Offset> points;
  final int strokeCount;
  final bool isValid;

  const WritingTraceState({
    required this.status,
    this.question,
    this.points = const [],
    this.strokeCount = 0,
    this.isValid = false,
  });

  factory WritingTraceState.initial() =>
      const WritingTraceState(status: WritingTraceStatus.initial);

  WritingTraceState copyWith({
    WritingTraceStatus? status,
    WritingTraceQuestion? question,
    List<Offset>? points,
    int? strokeCount,
    bool? isValid,
  }) {
    return WritingTraceState(
      status: status ?? this.status,
      question: question ?? this.question,
      points: points ?? this.points,
      strokeCount: strokeCount ?? this.strokeCount,
      isValid: isValid ?? this.isValid,
    );
  }
}

/// =======================
/// CUBIT
/// =======================
class WritingTraceCubit extends Cubit<WritingTraceState> {
  WritingTraceCubit() : super(WritingTraceState.initial());

  void startQuiz(WritingTraceQuestion question) {
    emit(
      state.copyWith(
        question: question,
        status: WritingTraceStatus.ready,
        points: [],
        strokeCount: 0,
        isValid: false,
      ),
    );
  }

  void startStroke() {
    emit(state.copyWith(strokeCount: state.strokeCount + 1));
  }

  void addPoint(Offset point) {
    final newPoints = [...state.points, point];
    emit(state.copyWith(points: newPoints));

    if (state.strokeCount >= state.question!.minStroke &&
        newPoints.length > 30) {
      emit(state.copyWith(status: WritingTraceStatus.answered, isValid: true));
    }
  }

  void reset() {
    emit(
      state.copyWith(
        points: [],
        strokeCount: 0,
        isValid: false,
        status: WritingTraceStatus.ready,
      ),
    );
  }
}

/// =======================
/// VIEW
/// =======================
class WritingTraceView extends StatelessWidget {
  final WritingTraceQuestion question;

  const WritingTraceView({super.key, required this.question});

  void _listener(BuildContext context, WritingTraceState state) {
    if (state.status == WritingTraceStatus.answered) {
      final snackBar = QuizSnackBar(
        onOk: () {},
        correctAnswer: state.question!.target,
      );

      snackBar.show(
        context,
        type: state.isValid
            ? QuizSnackBarType.correct
            : QuizSnackBarType.incorrect,
      );

      Future.delayed(const Duration(seconds: 1), () {
        if (context.mounted) {
          context.read<QuizBloc>().add(
            NextQuestionRequested(wasCorrect: state.isValid),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return BlocProvider(
      key: ValueKey(question.id),
      create: (_) => WritingTraceCubit()..startQuiz(question),
      child: BlocConsumer<WritingTraceCubit, WritingTraceState>(
        listener: _listener,
        builder: (context, state) {
          if (state.status == WritingTraceStatus.initial) {
            return const Expanded(child: CircularProgressIndicator());
          }

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Ikuti bentuk huruf di bawah ini",
                      style: TextStyle(
                        fontSize: 20,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// CANVAS
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: color.outline),
                      ),
                      child: GestureDetector(
                        onPanStart: (_) =>
                            context.read<WritingTraceCubit>().startStroke(),
                        onPanUpdate: (details) => context
                            .read<WritingTraceCubit>()
                            .addPoint(details.localPosition),
                        child: CustomPaint(
                          painter: _TracePainter(
                            points: state.points,
                            target: question.target,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Garis: ${state.strokeCount}/${question.minStroke}",
                        style: TextStyle(
                          fontSize: 14,
                          color: color.onSurfaceVariant,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: context.read<WritingTraceCubit>().reset,
                        icon: const Icon(Icons.refresh),
                        label: const Text("Ulangi"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// =======================
/// PAINTER
/// =======================
class _TracePainter extends CustomPainter {
  final List<Offset> points;
  final String target;

  _TracePainter({required this.points, required this.target});

  @override
  void paint(Canvas canvas, Size size) {
    /// Draw user strokes
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }

    /// Draw guide text
    final textPainter = TextPainter(
      text: TextSpan(
        text: target,
        style: TextStyle(
          fontSize: size.width * 0.6,
          color: Colors.grey.withOpacity(0.25),
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) / 2,
        (size.height - textPainter.height) / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
