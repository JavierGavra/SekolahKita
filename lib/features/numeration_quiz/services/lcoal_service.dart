import 'package:sekolah_kita/features/numeration_quiz/models/multiple_choice_model.dart';

class LocalService {
  List<MultipleChoiceModel> getQuestions() {
    return [
      // Question 1: Simple Addition
      MultipleChoiceModel(
        id: 1,
        question: '2 + 3 = ?',
        imagePath: '➕',
        options: [
          AnswerOption(id: 'a', text: '4'),
          AnswerOption(id: 'b', text: '5'),
          AnswerOption(id: 'c', text: '6'),
          AnswerOption(id: 'd', text: '7'),
        ],
        correctAnswerId: 'b',
      ),

      // Question 2: Simple Subtraction
      MultipleChoiceModel(
        id: 2,
        question: '8 - 3 = ?',
        imagePath: '➖',
        options: [
          AnswerOption(id: 'a', text: '4'),
          AnswerOption(id: 'b', text: '5'),
          AnswerOption(id: 'c', text: '6'),
          AnswerOption(id: 'd', text: '3'),
        ],
        correctAnswerId: 'b',
      ),

      // Question 3: Counting Objects
      MultipleChoiceModel(
        id: 3,
        question: 'Ada berapa apel? 🍎🍎🍎🍎🍎',
        imagePath: null,
        options: [
          AnswerOption(id: 'a', text: '3'),
          AnswerOption(id: 'b', text: '4'),
          AnswerOption(id: 'c', text: '5'),
          AnswerOption(id: 'd', text: '6'),
        ],
        correctAnswerId: 'c',
      ),

      // Question 4: Multiplication
      MultipleChoiceModel(
        id: 4,
        question: '3 × 2 = ?',
        imagePath: '✖️',
        options: [
          AnswerOption(id: 'a', text: '5'),
          AnswerOption(id: 'b', text: '6'),
          AnswerOption(id: 'c', text: '7'),
          AnswerOption(id: 'd', text: '8'),
        ],
        correctAnswerId: 'b',
      ),

      // Question 5: Number Comparison
      MultipleChoiceModel(
        id: 5,
        question: 'Angka mana yang lebih besar?',
        imagePath: '🔢',
        options: [
          AnswerOption(id: 'a', text: '7'),
          AnswerOption(id: 'b', text: '5'),
          AnswerOption(id: 'c', text: '3'),
          AnswerOption(id: 'd', text: '9'),
        ],
        correctAnswerId: 'd',
      ),

      // Question 6: Addition with larger numbers
      MultipleChoiceModel(
        id: 6,
        question: '10 + 5 = ?',
        imagePath: '➕',
        options: [
          AnswerOption(id: 'a', text: '13'),
          AnswerOption(id: 'b', text: '14'),
          AnswerOption(id: 'c', text: '15'),
          AnswerOption(id: 'd', text: '16'),
        ],
        correctAnswerId: 'c',
      ),

      // Question 7: Counting by twos
      MultipleChoiceModel(
        id: 7,
        question: 'Lanjutkan: 2, 4, 6, ?',
        imagePath: '🔢',
        options: [
          AnswerOption(id: 'a', text: '7'),
          AnswerOption(id: 'b', text: '8'),
          AnswerOption(id: 'c', text: '9'),
          AnswerOption(id: 'd', text: '10'),
        ],
        correctAnswerId: 'b',
      ),

      // Question 8: Simple Division
      MultipleChoiceModel(
        id: 8,
        question: '12 ÷ 3 = ?',
        imagePath: '➗',
        options: [
          AnswerOption(id: 'a', text: '3'),
          AnswerOption(id: 'b', text: '4'),
          AnswerOption(id: 'c', text: '5'),
          AnswerOption(id: 'd', text: '6'),
        ],
        correctAnswerId: 'b',
      ),

      // Question 9: Word Problem
      MultipleChoiceModel(
        id: 9,
        question: 'Kamu punya 7 permen, makan 2. Sisanya?',
        imagePath: '🍬',
        options: [
          AnswerOption(id: 'a', text: '4'),
          AnswerOption(id: 'b', text: '5'),
          AnswerOption(id: 'c', text: '6'),
          AnswerOption(id: 'd', text: '7'),
        ],
        correctAnswerId: 'b',
      ),

      // Question 10: Number Pattern
      MultipleChoiceModel(
        id: 10,
        question: 'Angka mana yang hilang?\n5, 10, ?, 20',
        imagePath: '❓',
        options: [
          AnswerOption(id: 'a', text: '12'),
          AnswerOption(id: 'b', text: '13'),
          AnswerOption(id: 'c', text: '14'),
          AnswerOption(id: 'd', text: '15'),
        ],
        correctAnswerId: 'd',
      ),
    ];
  }
}
