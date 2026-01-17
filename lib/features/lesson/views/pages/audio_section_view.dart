import 'package:flutter/material.dart';
import 'package:sekolah_kita/core/database/static/models/lesson_section/audio_section.dart';
import 'package:sekolah_kita/features/lesson/services/tts_service.dart';

class AudioSectionView extends StatelessWidget {
  final AudioSection section;

  const AudioSectionView({super.key, required this.section});

  void _speak() {
    TtsService()
      ..useIndonesianMale()
      ..speak(section.textToSpeech);
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    _speak();

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Bagaimana suaranya?",
                style: TextStyle(
                  fontSize: 20,
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

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
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(height: 16),

            InkWell(
              onTap: _speak,
              splashColor: color.tertiary,
              borderRadius: BorderRadius.circular(24),
              child: Ink(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 2,
                  children: [
                    Icon(Icons.volume_up_rounded, size: 42),
                    Text("Tekan agar berbunyi"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
