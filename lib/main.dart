import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_kita/bloc/provider.dart';
import 'package:sekolah_kita/core/theme/theme.dart';
import 'package:sekolah_kita/features/course/views/pages/course_page.dart';
import 'package:sekolah_kita/features/quiz/views/pre_quiz_screen.dart';
import 'package:sekolah_kita/features/splashscreen/views/pages/splashscreen.dart';
import 'package:sekolah_kita/features/course/views/pages/course_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: Provider.providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Outfit',
          useMaterial3: true,
          colorScheme: MaterialTheme.lightScheme(),
        ),
        home: const Splashscreen(),
      ),
    );
  }
}
