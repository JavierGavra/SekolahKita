import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_kita/features/course/cubit/course/course_cubit.dart';

class LessonResultPage extends StatelessWidget {
  const LessonResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    context.read<CourseCubit>().loadData();

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
          child: Transform.rotate(angle: value * 0.2, child: child),
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
        child: Text('✅', style: const TextStyle(fontSize: 36)),
      ),
    );
  }

  List<Widget> _buildTitle(ColorScheme color) {
    return [
      Text(
        'Selamat',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: color.onSurface,
          height: 1.285,
        ),
      ),
      const SizedBox(height: 5),
      Text(
        'Kamu telah menyelesaikan materi ini',
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
