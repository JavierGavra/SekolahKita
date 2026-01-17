import 'package:flutter/material.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section/text_section.dart';

class TextSectionView extends StatelessWidget {
  final TextSection section;

  const TextSectionView({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // const Align(
            //   alignment: Alignment.topLeft,
            //   child: Text(
            //     "Info",
            //     style: TextStyle(
            //       fontSize: 20,
            //       height: 1.4,
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: color.primaryContainer,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                section.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color.onPrimaryContainer,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
