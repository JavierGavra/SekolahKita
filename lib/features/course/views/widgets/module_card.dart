import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sekolah_kita/core/theme/theme.dart';
import 'package:sekolah_kita/core/utils/navigate/navigate.dart';
import 'package:sekolah_kita/features/course/models/course_types.dart';
import 'package:sekolah_kita/features/reading_quiz/views/pages/reading_quiz_page.dart';
import '../../models/module_model.dart';
import '../pages/material_content_page.dart';

class ModuleCard extends StatelessWidget {
  final ModuleModel module;
  final CourseType type;

  const ModuleCard({super.key, required this.module, required this.type});

  void _onTap(BuildContext context) {
    // Jika modul locked, tampilkan snackbar
    if (module.isLocked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selesaikan modul sebelumnya terlebih dahulu'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Jika tipe Materi, buka MaterialContentPage
    if (module.type == ModuleType.material) {
      Navigate.push(context, MaterialContentPage(module: module));
    }
    // Jika tipe Kuis, tampilkan coming soon
    else if (module.type == ModuleType.quiz) {
      context.pushTransition(
        curve: Curves.easeIn,
        type: PageTransitionType.rightToLeft,
        child: ReadingQuizPage(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    final borderColor = switch (type) {
      CourseType.reading => color.primaryContainer,
      CourseType.writing => color.tertiaryContainer,
      CourseType.numeration => color.secondaryContainer,
    };

    return Material(
      color: color.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => _onTap(context),
        splashColor: color.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        child: Opacity(
          opacity: module.isLocked ? 0.6 : 1,
          child: Ink(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor),
            ),
            child: Row(
              children: [
                _buildIcon(color),
                const SizedBox(width: 16),
                Expanded(child: _buildContent(color)),
                if (module.isCompleted) _buildCompletedIndicator(color),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(ColorScheme color) {
    final isMateri = module.type == ModuleType.material;
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: isMateri ? color.primaryContainer : color.tertiaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        (module.isLocked)
            ? Icons.lock_outline_rounded
            : (isMateri)
            ? Icons.menu_book_rounded
            : Icons.assignment_outlined,
        color: isMateri ? color.onPrimaryContainer : color.onTertiaryContainer,
        size: 20,
      ),
    );
  }

  Widget _buildTypeChip(ColorScheme color) {
    final isMateri = module.type == ModuleType.material;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.surfaceContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        isMateri ? "Materi" : "Kuis",
        style: TextStyle(
          fontWeight: FontWeight.w500,
          height: 1.333,
          fontSize: 12,
          color: isMateri ? color.primary : color.tertiary,
        ),
      ),
    );
  }

  Widget _buildContent(ColorScheme color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(
          module.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            height: 1.5,
          ),
        ),
        Row(
          children: [
            _buildTypeChip(color),
            if (module.isCompleted) ...[
              const SizedBox(width: 8),
              Icon(
                Icons.check_circle_outline_rounded,
                color: color.success,
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(
                'Selesai',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  height: 1.333,
                  fontSize: 12,
                  color: color.success,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildCompletedIndicator(ColorScheme color) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(color: color.success, shape: BoxShape.circle),
      child: Icon(
        Icons.check_circle_outline_rounded,
        color: color.onSuccess,
        size: 16,
      ),
    );
  }
}
