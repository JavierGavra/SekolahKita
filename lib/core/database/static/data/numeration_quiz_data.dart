import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/question/multiple_choice_question.dart';
import 'package:sekolah_kita/core/database/static/models/question/speech_question.dart';
import 'package:sekolah_kita/core/database/static/models/quiz_model.dart';
import 'package:sekolah_kita/core/database/static/models/quiz_question_model.dart';

class NumerationQuizData {
  List<QuizQuestionModel> getQuestion(int moduleId) {
    return _quizData
        .firstWhere((element) => element.moduleId == moduleId)
        .questions;
  }

  final List<QuizModel> _quizData = [
    QuizModel(
      id: 1,
      moduleId: 2,
      course: CourseType.numeration,
      questions: [
        SpeechQuestion(id: 1, text: 'Satu', imagePath: "1"),
        SpeechQuestion(id: 2, text: 'Dua', imagePath: "2"),
        SpeechQuestion(id: 3, text: 'Tiga', imagePath: "3"),
        SpeechQuestion(id: 4, text: 'Empat', imagePath: "4"),
        SpeechQuestion(id: 5, text: 'Lima', imagePath: "5"),
        SpeechQuestion(id: 6, text: 'Enam', imagePath: "6"),
        SpeechQuestion(id: 7, text: 'Tujuh', imagePath: "7"),
        SpeechQuestion(id: 8, text: 'Delapan', imagePath: "8"),
        SpeechQuestion(id: 9, text: 'Sembilan', imagePath: "9"),
        SpeechQuestion(id: 10, text: 'Sepuluh', imagePath: "10"),
      ],
    ),
    QuizModel(
      id: 2,
      moduleId: 4,
      course: CourseType.numeration,
      questions: [
        MultipleChoiceQuestion(
          id: 1,
          question: 'Ada berapa apel di bawah ini \n 🍎🍎🍎🍎',
          imagePath: "",
          options: ['5', '1', '7', '4'],
          correctAnswerId: 3,
        ),
        MultipleChoiceQuestion(
          id: 2,
          question: 'Ada berapa gajah di bawah ini \n🐘🐘',
          imagePath: "",
          options: ['2', '9', '5', '8'],
          correctAnswerId: 0,
        ),
        MultipleChoiceQuestion(
          id: 3,
          question: 'Ada berapa jeruk di bawah ini \n 🍊🍊🍊🍊🍊🍊🍊',
          imagePath: "",
          options: ['10', '3', '7', '1'],
          correctAnswerId: 2,
        ),
        MultipleChoiceQuestion(
          id: 4,
          question: 'Ada berapa singa di bawah ini \n 🦁🦁🦁🦁🦁',
          imagePath: "",
          options: ['6', '5', '2', '8'],
          correctAnswerId: 1,
        ),
        MultipleChoiceQuestion(
          id: 5,
          question: 'Ada berapa mangga di bawah ini \n 🥭 ',
          imagePath: "",
          options: ['1', '6', '10', '3'],
          correctAnswerId: 0,
        ),
        MultipleChoiceQuestion(
          id: 6,
          question: 'Ada berapa sapi di bawah ini \n 🐄🐄🐄🐄🐄🐄🐄🐄🐄',
          imagePath: "",
          options: ['8', '4', '7', '9'],
          correctAnswerId: 3,
        ),
        MultipleChoiceQuestion(
          id: 7,
          question: 'Ada berapa pir di bawah ini \n 🍐🍐🍐🍐🍐🍐🍐🍐',
          imagePath: "",
          options: ['10', '8', '2', '7'],
          correctAnswerId: 1,
        ),
        MultipleChoiceQuestion(
          id: 8,
          question: 'Ada berapa ayam di bawah ini \n 🐔🐔🐔🐔🐔🐔',
          imagePath: "",
          options: ['9', '3', '6', '1'],
          correctAnswerId: 3,
        ),
        MultipleChoiceQuestion(
          id: 9,
          question: 'Ada berapa kelapa di bawah ini \n 🥥🥥🥥',
          imagePath: "",
          options: ['3', '10', '5', '6'],
          correctAnswerId: 0,
        ),
        MultipleChoiceQuestion(
          id: 10,
          question: 'Ada berapa bebek di bawah ini \n 🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆',
          imagePath: "",
          options: ['1', '4', '10', '3'],
          correctAnswerId: 2,
        ),
      ],
    ),
    QuizModel(
      id: 3,
      moduleId: 6,
      course: CourseType.numeration,
      questions: [
        MultipleChoiceQuestion(
          id: 1,
          question: '1 + 1',
          imagePath: "",
          options: ['2', '5', '8', '6'],
          correctAnswerId: 0,
        ),
        MultipleChoiceQuestion(
          id: 2,
          question: '1 + 7',
          imagePath: "",
          options: ['1', '10', '8', '3'],
          correctAnswerId: 2,
        ),
        MultipleChoiceQuestion(
          id: 3,
          question: '2 + 1',
          imagePath: "",
          options: ['9', '3', '7', '8'],
          correctAnswerId: 1,
        ),
        MultipleChoiceQuestion(
          id: 4,
          question: '4 + 6',
          imagePath: "",
          options: ['1', '6', '8', '10'],
          correctAnswerId: 3,
        ),
        MultipleChoiceQuestion(
          id: 5,
          question: '2 + 3',
          imagePath: "",
          options: ['5', '9', '7', '4'],
          correctAnswerId: 0,
        ),
        MultipleChoiceQuestion(
          id: 6,
          question: '4 + 3',
          imagePath: "",
          options: ['10', '3', '7', '6'],
          correctAnswerId: 2,
        ),
        MultipleChoiceQuestion(
          id: 7,
          question: '7 + 2',
          imagePath: "",
          options: ['3', '9', '1', '7'],
          correctAnswerId: 1,
        ),
        MultipleChoiceQuestion(
          id: 8,
          question: '3 + 3',
          imagePath: "",
          options: ['4', '2', '9', '6'],
          correctAnswerId: 3,
        ),
        MultipleChoiceQuestion(
          id: 9,
          question: '1 + 3',
          imagePath: "",
          options: ['7', '4', '1', '9'],
          correctAnswerId: 1,
        ),
        MultipleChoiceQuestion(
          id: 10,
          question: '9 + 1',
          imagePath: "",
          options: ['1', '10', '5', '7'],
          correctAnswerId: 1,
        ),
      ],
    ),
    QuizModel(
      id: 1,
      moduleId: 8,
      course: CourseType.numeration,
      questions: [
        MultipleChoiceQuestion(
          id: 1,
          question: '10 - 1',
          imagePath: "",
          options: ['9', '10', '1', '5'],
          correctAnswerId: 0,
        ),
        MultipleChoiceQuestion(
          id: 2,
          question: '5 - 4',
          imagePath: "",
          options: ['5', '1', '8', '3'],
          correctAnswerId: 1,
        ),
        MultipleChoiceQuestion(
          id: 3,
          question: '10 - 2',
          imagePath: "",
          options: ['3', '7', '4', '8'],
          correctAnswerId: 3,
        ),
        MultipleChoiceQuestion(
          id: 4,
          question: '7 - 5',
          imagePath: "",
          options: ['6', '1', '2', '9'],
          correctAnswerId: 2,
        ),
        MultipleChoiceQuestion(
          id: 5,
          question: '9 - 2',
          imagePath: "",
          options: ['10', '4', '2', '7'],
          correctAnswerId: 3,
        ),
        MultipleChoiceQuestion(
          id: 6,
          question: '8 - 5',
          imagePath: "",
          options: ['3', '8', '5', '9'],
          correctAnswerId: 0,
        ),
        MultipleChoiceQuestion(
          id: 7,
          question: '7 - 1',
          imagePath: "",
          options: ['1', '6', '7', '3'],
          correctAnswerId: 1,
        ),
        MultipleChoiceQuestion(
          id: 8,
          question: '6 - 2',
          imagePath: "",
          options: ['6', '3', '4', '9'],
          correctAnswerId: 2,
        ),
        MultipleChoiceQuestion(
          id: 9,
          question: '10 - 5',
          imagePath: "",
          options: ['5', '8', '1', '10'],
          correctAnswerId: 0,
        ),
        MultipleChoiceQuestion(
          id: 10,
          question: '8 - 4',
          imagePath: "",
          options: ['1', '9', '4', '5'],
          correctAnswerId: 2,
        ),
      ],
    ),
  ];
}
