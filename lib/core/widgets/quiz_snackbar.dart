import 'package:flutter/material.dart';
import 'package:sekolah_kita/core/theme/theme.dart';

enum QuizSnackBarType { correct, incorrect, almost }

class QuizSnackBar {
  final VoidCallback onOk;
  final String correctAnswer;

  const QuizSnackBar({required this.onOk, required this.correctAnswer});

  SnackBar _createSnackBar(
    BuildContext context,
    String? currentAnswaer,
    QuizSnackBarType type,
    String? message,
  ) {
    final color = Theme.of(context).colorScheme;
    late String title;
    late Color backgroundColor;
    late IconData icon;

    switch (type) {
      case QuizSnackBarType.correct:
        title = "Benar!";
        backgroundColor = color.success;
        icon = Icons.check_circle_rounded;
        break;
      case QuizSnackBarType.incorrect:
        title = "Salah";
        backgroundColor = color.error;
        icon = Icons.cancel_rounded;
        break;
      case QuizSnackBarType.almost:
        title = "Hampir benar";
        backgroundColor = Colors.deepOrange;
        icon = Icons.warning_rounded;
        break;
    }

    return SnackBar(
      backgroundColor: backgroundColor,
      padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
      duration: const Duration(seconds: 2),
      action: (type == QuizSnackBarType.almost)
          ? null
          : SnackBarAction(
              onPressed: onOk,
              label: 'Lanjut',
              backgroundColor: color.surface,
              textColor: color.onSurface,
            ),
      content: Row(
        children: [
          Icon(icon, color: color.onSuccess, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    height: 1.272,
                  ),
                ),
                const SizedBox(height: 2),
                if (type == QuizSnackBarType.almost) ...[
                  Text(
                    "Jawabanmu : $currentAnswaer",
                    style: TextStyle(fontSize: 13, height: 1.538),
                  ),
                  Text(
                    "Seharusnya : $correctAnswer",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, height: 1.538),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void show(
    BuildContext context, {
    required QuizSnackBarType type,
    String? currentAnswaer,
    String? message,
  }) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(_createSnackBar(context, currentAnswaer, type, message));
  }
}
