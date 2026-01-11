import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_kita/features/reading_quiz/bloc/reading_quiz_bloc.dart';
import 'package:sekolah_kita/features/reading_quiz/views/pages/reading_quiz_view.dart';

class ReadingQuizPage extends StatelessWidget {
  const ReadingQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReadingQuizBloc()..add(ReadingQuizStarted()),
      child: const ReadingQuizView(),
    );
  }
}
