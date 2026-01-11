import 'package:flutter/material.dart';

class ReadingQuizModel {
  final int number;
  final String text;
  final int difficulty; // 1: Easy, 2: Medium, 3: Hard
  final String? imagePath;

  ReadingQuizModel({
    required this.number,
    required this.text,
    required this.difficulty,
    this.imagePath,
  });

  String get difficultyLabel {
    switch (difficulty) {
      case 1:
        return 'Mudah';
      case 2:
        return 'Sedang';
      case 3:
        return 'Sulit';
      default:
        return 'Mudah';
    }
  }

  String get difficultyEmoji {
    return switch (difficulty) {
      1 => '😀',
      2 => '😐',
      3 => '😡',
      int() => throw UnimplementedError(),
    };
  }

  Color get difficultyColor {
    switch (difficulty) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.red;
      default:
        return Colors.green;
    }
  }
}
