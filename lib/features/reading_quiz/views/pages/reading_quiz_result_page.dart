import 'package:flutter/material.dart';

class ReadingQuizResultPage extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  final int percentage;

  const ReadingQuizResultPage({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.percentage,
  });

  String get resultEmoji {
    if (percentage >= 90) return '🏆';
    if (percentage >= 70) return '🌟';
    if (percentage >= 50) return '👍';
    return '💪';
  }

  String get resultTitle {
    if (percentage >= 90) return 'Luar Biasa!';
    if (percentage >= 70) return 'Bagus Sekali!';
    if (percentage >= 50) return 'Lumayan Bagus!';
    return 'Terus Berlatih!';
  }

  String get resultMessage {
    if (percentage >= 90) return 'Kamu pembaca yang hebat! 🎉';
    if (percentage >= 70) return 'Bacaanmu sudah bagus! Pertahankan!';
    if (percentage >= 50) return 'Cukup bagus! Yuk latihan lagi!';
    return 'Jangan menyerah! Terus berlatih ya! 💪';
  }

  Color get resultColor {
    if (percentage >= 70) return Colors.green;
    if (percentage >= 50) return Colors.red;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIcon(color),
              const SizedBox(height: 32),
              ..._buildTitle(color),
              const SizedBox(height: 48),
              _buildScoreCard(color),
              const SizedBox(height: 16),
              _buildHomeButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(ColorScheme color) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 800),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Transform.rotate(angle: value * 0.5, child: child),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(36),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [color.surface, color.primary],
          ),
        ),
        child: Text(resultEmoji, style: const TextStyle(fontSize: 36)),
      ),
    );
  }

  List<Widget> _buildTitle(ColorScheme color) {
    return [
      Text(
        resultTitle,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: color.onSurface,
          height: 1.285,
        ),
      ),
      const SizedBox(height: 5),
      Text(
        resultMessage,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: color.onSurfaceVariant,
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
      ),
    ];
  }

  Widget _buildScoreCard(ColorScheme color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.primaryContainer),
      ),
      child: Column(
        children: [
          Text(
            '$percentage%',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: resultColor,
              height: 1.333,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '$correctAnswers dari $totalQuestions benar',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
              height: 1.428,
            ),
          ),
          const SizedBox(height: 6),
          const Divider(thickness: 2),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              final starThreshold = [50, 70, 90][index];
              final isFilled = percentage >= starThreshold;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Icon(
                  isFilled ? Icons.star_rounded : Icons.star_border_rounded,
                  size: 30,
                  color: isFilled ? Colors.amber : color.surfaceContainerHigh,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeButton(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20),
          side: BorderSide(color: color.primary, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          'Kembali ke Menu',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: color.primary,
          ),
        ),
      ),
    );
  }
}
