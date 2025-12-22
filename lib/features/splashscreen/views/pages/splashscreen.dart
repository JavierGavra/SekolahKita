import 'package:flutter/material.dart';
import 'package:sekolah_kita/core/database/database_helper.dart';
import 'package:sekolah_kita/core/utils/navigate/navigate.dart';
import 'package:sekolah_kita/features/introduction/views/pages/introduction_page.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 700));
    await DatabaseHelper.instance.database;

    if (context.mounted) {
      Navigate.push(context, IntroductionPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    init(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [color.primary, Color(0xFF0F4A5F)],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 128,
              width: 128,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.surfaceContainerLowest.withValues(alpha: 0.2),
              ),
              child: Icon(
                Icons.school_outlined,
                size: 64,
                color: color.onPrimary,
              ),
            ),
            SizedBox(height: 46),
            Text(
              "SekolahKita",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                height: 1.1875,
                color: color.onPrimary,
              ),
            ),
            SizedBox(height: 17),
            Text(
              "Belajar Bersama, Tumbuh Bersama",
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: color.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
