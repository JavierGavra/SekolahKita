// lib/features/quiz/views/quiz_result_screen.dart

import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/quiz_models.dart';
import 'quiz_review_screen.dart';
import 'pre_quiz_screen.dart';

class QuizResultScreen extends StatefulWidget {
  final QuizResult result;
  final Quiz quiz;

  const QuizResultScreen({super.key, required this.result, required this.quiz});

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen>
    with TickerProviderStateMixin {
  late AnimationController _confettiController;
  late AnimationController _scoreController;
  late AnimationController _bounceController;
  late Animation<double> _scoreAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();

    _scoreController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _scoreAnimation =
        Tween<double>(begin: 0, end: widget.result.score.toDouble()).animate(
          CurvedAnimation(parent: _scoreController, curve: Curves.easeOutCubic),
        );

    _bounceAnimation = Tween<double>(begin: 0, end: 15).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
    );

    _scoreController.forward();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _scoreController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  void _reviewAnswers() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            QuizReviewScreen(result: widget.result, quiz: widget.quiz),
      ),
    );
  }

  void _retakeQuiz() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PreQuizScreen(moduleId: widget.quiz.moduleId),
      ),
    );
  }

  void _finishQuiz() {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SafeArea(
          child: Stack(
            children: [
              // Confetti background for passed
              if (widget.result.passed)
                AnimatedBuilder(
                  animation: _confettiController,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: ConfettiPainter(_confettiController.value),
                      size: Size.infinite,
                    );
                  },
                ),

              // Main Content
              SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Giant Emoji Result
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.elasticOut,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Text(
                            widget.result.passed ? '🎉' : '💪',
                            style: const TextStyle(fontSize: 120),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // Result Message
                    Text(
                      widget.result.passed ? 'LUAR BIASA!' : 'HAMPIR!',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: widget.result.passed
                            ? const Color(0xFF4CAF50)
                            : Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.result.passed ? 'Kamu berhasil!' : 'Coba lagi ya!',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Animated Score Circle
                    AnimatedBuilder(
                      animation: _scoreAnimation,
                      builder: (context, child) {
                        return Container(
                          width: 220,
                          height: 220,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: widget.result.passed
                                  ? [
                                      const Color(0xFF4CAF50),
                                      const Color(0xFF66BB6A),
                                    ]
                                  : [Colors.orange[400]!, Colors.orange[600]!],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    (widget.result.passed
                                            ? const Color(0xFF4CAF50)
                                            : Colors.orange)
                                        .withOpacity(0.5),
                                blurRadius: 30,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'SKOR',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 2,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${_scoreAnimation.value.round()}',
                                      style: const TextStyle(
                                        fontSize: 64,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        height: 1,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        '/100',
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),

                    // Stats Cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            '✅',
                            '${widget.result.correctAnswers}',
                            'Benar',
                            const Color(0xFF4CAF50),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            '❌',
                            '${widget.result.wrongAnswers}',
                            'Salah',
                            Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildFullStatCard(
                      '⏱️',
                      _formatDuration(widget.result.timeUsed),
                      'Waktu Digunakan',
                      Colors.blue,
                    ),
                    const SizedBox(height: 40),

                    // Action Buttons
                    AnimatedBuilder(
                      animation: _bounceAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, -_bounceAnimation.value),
                          child: child,
                        );
                      },
                      child: Column(
                        children: [
                          // Review Button
                          _buildActionButton(
                            onPressed: _reviewAnswers,
                            emoji: '📝',
                            label: 'Lihat Jawaban',
                            color: const Color(0xFF1A6585),
                          ),
                          const SizedBox(height: 16),

                          // Retry or Continue Button
                          if (!widget.result.passed)
                            _buildActionButton(
                              onPressed: _retakeQuiz,
                              emoji: '🔄',
                              label: 'Coba Lagi',
                              color: Colors.orange,
                            )
                          else
                            _buildActionButton(
                              onPressed: _finishQuiz,
                              emoji: '🎯',
                              label: 'Lanjut Belajar',
                              color: const Color(0xFF4CAF50),
                            ),
                          const SizedBox(height: 16),

                          // Home Button
                          if (!widget.result.passed)
                            OutlinedButton(
                              onPressed: _finishQuiz,
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 20,
                                ),
                                side: const BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('🏠', style: TextStyle(fontSize: 28)),
                                  SizedBox(width: 12),
                                  Text(
                                    'Kembali',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String emoji, String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullStatCard(
    String emoji,
    String value,
    String label,
    Color color,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 48)),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onPressed,
    required String emoji,
    required String label,
    required Color color,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 8,
          shadowColor: color.withOpacity(0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes menit $seconds detik';
  }
}

class ConfettiPainter extends CustomPainter {
  final double animationValue;

  ConfettiPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final random = math.Random(42);

    for (int i = 0; i < 50; i++) {
      final x = random.nextDouble() * size.width;
      final y =
          (animationValue * size.height + random.nextDouble() * 100) %
          (size.height + 100);
      final color = [
        Colors.red,
        Colors.blue,
        Colors.green,
        Colors.yellow,
        Colors.purple,
        Colors.orange,
      ][random.nextInt(6)];

      paint.color = color;
      canvas.drawCircle(Offset(x, y), 5, paint);
    }
  }

  @override
  bool shouldRepaint(ConfettiPainter oldDelegate) => true;
}
