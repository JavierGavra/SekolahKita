import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_kita/features/quiz/cubit/speech/speech_cubit.dart';

class MicrophoneButton extends StatelessWidget {
  const MicrophoneButton({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return BlocBuilder<SpeechCubit, SpeechState>(
      builder: (context, state) {
        Function()? onTap;
        List<BoxShadow>? shadow;
        IconData icon = Icons.blur_circular;
        Color iconColor = color.primary;
        String text = "Mendengarkan...";

        if (state.status == SpeechStateStatus.listening ||
            state.status == SpeechStateStatus.answered) {
          onTap = () {};
        } else {
          onTap = () => context.read<SpeechCubit>().listeningStarted();
        }

        if (state.status != SpeechStateStatus.listening) {
          icon = Icons.mic;
          iconColor = color.onPrimary;
          text = "Tekan untuk bicara";
          shadow = [
            BoxShadow(
              color: color.primary.withValues(alpha: 0.3),
              blurRadius: 15,
              spreadRadius: 3,
            ),
          ];
        }

        return Column(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: onTap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: (state.status == SpeechStateStatus.listening)
                      ? color.surfaceContainer
                      : color.primary,
                  shape: BoxShape.circle,
                  boxShadow: shadow,
                ),
                child: Icon(icon, size: 48, color: iconColor),
              ),
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color.onSurfaceVariant,
                fontWeight: FontWeight.w500,
                height: 1.428,
              ),
            ),
          ],
        );
      },
    );
  }
}
