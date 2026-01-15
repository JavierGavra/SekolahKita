import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/question/listening_question.dart';
import 'package:sekolah_kita/core/database/static/models/question/multiple_choice_question.dart';
import 'package:sekolah_kita/core/database/static/models/question/multiple_sound_question.dart';
import 'package:sekolah_kita/core/database/static/models/question/speech_question.dart';
import 'package:sekolah_kita/core/database/static/models/quiz_model.dart';
import 'package:sekolah_kita/core/database/static/models/quiz_question_model.dart';

class ReadingQuizData {
  List<QuizQuestionModel> getQuestion(int moduleId) {
    return _quizData
        .firstWhere((element) => element.moduleId == moduleId)
        .questions;
  }

  final List<QuizModel> _quizData = [
    QuizModel(
      id: 1,
      moduleId: 2,
      course: CourseType.reading,
      questions: [
        ListeningQuestion(
          id: 1,
          text: "U",
          options: ["A", "I", "U", "O"],
          correctAnswerId: 2,
        ),
        ListeningQuestion(
          id: 2,
          text: "I",
          options: ["A", "I", "U", "O"],
          correctAnswerId: 1,
        ),
        ListeningQuestion(
          id: 3,
          text: "E",
          options: ["E", "I", "U", "O"],
          correctAnswerId: 0,
        ),
        ListeningQuestion(
          id: 4,
          text: "O",
          options: ["A", "I", "U", "O"],
          correctAnswerId: 3,
        ),
        ListeningQuestion(
          id: 5,
          text: "A",
          options: ["A", "I", "U", "O"],
          correctAnswerId: 0,
        ),
        MultipleSoundQuestion(
          id: 6, 
          text: "E", 
          options: ["A","E"], 
          correctAnswerId: 1,
        ),
        MultipleSoundQuestion(
          id: 7, 
          text: "I", 
          options: ["I","E"], 
          correctAnswerId: 0,
        ),
        MultipleSoundQuestion(
          id: 8, 
          text: "O", 
          options: ["I","O"], 
          correctAnswerId: 1,
        ),
      ],
    ),
    QuizModel(
      id: 2,
      moduleId: 4,
      course: CourseType.reading,
      questions: [
        ListeningQuestion(
          id: 1,
          text: "K",
          options: ["K", "B", "C", "D"],
          correctAnswerId: 0,
        ),
        MultipleSoundQuestion(
          id: 2, 
          text: "T", 
          options: ["T","L"], 
          correctAnswerId: 0,
        ),
        MultipleSoundQuestion(
          id: 3, 
          text: "P", 
          options: ["R","P"], 
          correctAnswerId: 1,
        ),
        MultipleSoundQuestion(
          id: 4, 
          text: "F", 
          options: ["G","F"], 
          correctAnswerId: 1,
        ),
        ListeningQuestion(
          id: 5,
          text: "Q",
          options: ["W", "Q", "X", "M"],
          correctAnswerId: 1,
        ),
        ListeningQuestion(
          id: 6,
          text: "Y",
          options: ["D", "G", "H", "Y"],
          correctAnswerId: 3,
        ),
        ListeningQuestion(
          id: 7,
          text: "N",
          options: ["N", "Q", "X", "M"],
          correctAnswerId: 0,
        ),
        ListeningQuestion(
          id: 8,
          text: "L",
          options: ["P", "Q", "L", "M"],
          correctAnswerId: 2,
        ),
      ],
    ),
    QuizModel(
      id: 3, 
      moduleId: 6, 
      course: CourseType.reading,
      questions:[
        MultipleChoiceQuestion(
          id: 1,
          question: "Pilih suku kata untuk kata ini",
          imagePath: "🐄", 
          options: ["sa - pi", "si - pa", "pa - si", "su - pi"],
          correctAnswerId: 0,
          ),
        ListeningQuestion(
          id: 2, 
          text: "Buku",
          options: ["bu - ku", "ba - ku", "bu - ka", "bo - ku"], 
          correctAnswerId: 0,
          ),
        MultipleChoiceQuestion(
          id: 3, 
          question: "Gabungkan suku kata: ma - ta", 
          options: ["Mata", "Mama", "Tama", "Mana"], 
          correctAnswerId: 0,
          ),
        MultipleSoundQuestion(
          id: 4, 
          text: "Ro - ti", 
          options:["roti", "ratu"],
          correctAnswerId: 0,
          ),
        ListeningQuestion(
          id: 5, 
          text: "Ayam", 
          options: ["A - ya","Ya - ma","A - yam","Am - ya"], 
          correctAnswerId: 2,
          ),
        ListeningQuestion(
          id: 6, 
          text: "Susu", 
          options: ["Su - su","Sa - sa","Su - sa","Si - su"], 
          correctAnswerId: 0,
          ),
        MultipleChoiceQuestion(
          id: 7, 
          question: "Gabungkan suku kata: Bo - la", 
          options: ["Mabo", "Bula", "Bali", "Bola"], 
          correctAnswerId: 3,
          ),
        ListeningQuestion(
          id: 8, 
          text: "Rumah", 
          options: ["Ma - ru","Ra - ma","Ru - ma","Ru - mah"], 
          correctAnswerId: 3,
          ),
        MultipleSoundQuestion(
          id: 9, 
          text: "Ka - ki", 
          options:["Kaku", "Kaki"],
          correctAnswerId: 1,
          ),
        ListeningQuestion(
          id: 10, 
          text: "Topi", 
          options: ["To - pi","Ro - pi","To - bi","Ti - po"], 
          correctAnswerId: 0,
          ), 
        ],
      ),
    QuizModel(
      id: 4, 
      moduleId: 8, 
      course: CourseType.reading, 
      questions: [
        MultipleChoiceQuestion(
          id: 1, 
          question: "Ini gambar apa ya ?", 
          imagePath: "🐱",
          options: ['Kucing', "Sapi", "Ayam", "Ikan"], 
          correctAnswerId: 0,
          ),
        ListeningQuestion(
          id: 2, 
          text: "Buku", 
          options: ["Batu", "Buku", "Bola", "Sapu"], 
          correctAnswerId: 1,
          ),
        MultipleSoundQuestion(
          id: 3, 
          text: "Mata", 
          options: ["Mata", "Makan"], 
          correctAnswerId: 0,
          ),
        SpeechQuestion(
          id: 4, 
          text: "Ibu",
          imagePath: "👩",
          ),
        SpeechQuestion(
          id: 5, 
          text: "Sapi",
          imagePath: "🍚",
          ),
        ListeningQuestion(
          id: 6, 
          text: "Sapi", 
          options: ["Kaki","Sapi", "Sapu", "Topi"], 
          correctAnswerId: 1,
          ),
        MultipleSoundQuestion(
          id: 7, 
          text: "Bola", 
          options: ["Bola","Buku"], 
          correctAnswerId: 0,
          ),
        SpeechQuestion(
          id: 8, 
          text: "Rumah",
          imagePath: "🏠",
          ),
        MultipleChoiceQuestion(
          id: 9, 
          question: "Ini adalah ?", 
          imagePath: "🐔",
          options: ["Ayam", "Bebek", "Ikan", "Kucing"], 
          correctAnswerId: 0,
          ),
        SpeechQuestion(
          id: 10, 
          text: "Sapi",
          imagePath: "🐄",
          )
      ])
  ];
}
