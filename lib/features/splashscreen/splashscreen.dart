import 'package:flutter/material.dart';
import 'package:sekolah_kita/core/database/database_helper.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 3));
    await DatabaseHelper.instance.database;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Sekolah Kita"),
      )
    );
  }
}
