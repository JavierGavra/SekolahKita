import 'package:flutter/material.dart';
import 'package:sekolah_kita/core/theme/theme.dart';
import 'package:sekolah_kita/features/splashscreen/views/pages/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: MaterialTheme.lightScheme()),
      home: const Splashscreen(),
    );
  }
}
