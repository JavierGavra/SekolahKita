import 'package:flutter/material.dart';

Future<bool> showExitLessonDialog(BuildContext context) async {
  final color = Theme.of(context).colorScheme;

  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: Icon(Icons.warning_rounded, color: color.error, size: 36),
        title: const Text(
          'Keluar dari Materi?',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        content: const Text(
          'Progres materi yang di pelajari tidak akan disimpan.',
          style: TextStyle(height: 1.4),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Batal'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: color.error),
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Keluar'),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );

  return result ?? false;
}
