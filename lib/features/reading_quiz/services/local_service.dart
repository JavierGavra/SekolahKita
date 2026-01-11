import '../models/reading_quiz_model.dart';

class LocalService {
  List<ReadingQuizModel> getQuestions() {
    return [
      ReadingQuizModel(number: 1, text: 'Buku', difficulty: 1, imagePath: '📚'),
      ReadingQuizModel(
        number: 2,
        text: 'Kucing',
        difficulty: 1,
        imagePath: '🐱',
      ),
      ReadingQuizModel(
        number: 3,
        text: 'Makan',
        difficulty: 1,
        imagePath: '🍽️',
      ),
      ReadingQuizModel(
        number: 4,
        text: 'Kecil',
        difficulty: 2,
        imagePath: '🐱',
      ),
      ReadingQuizModel(
        number: 5,
        text: 'Besar',
        difficulty: 2,
        imagePath: '📚',
      ),
      // ReadingQuizModel(number: 6, text: 'Suka', difficulty: 2, imagePath: '📖'),
      // ReadingQuizModel(
      //   number: 7,
      //   text: 'Teman',
      //   difficulty: 2,
      //   imagePath: '👫',
      // ),
      // ReadingQuizModel(number: 8, text: 'Ibu', difficulty: 2, imagePath: '🛒'),
      // ReadingQuizModel(
      //   number: 9,
      //   text: 'Ayah',
      //   difficulty: 3,
      //   imagePath: '👨‍💼',
      // ),
      // ReadingQuizModel(
      //   number: 10,
      //   text: 'Adik',
      //   difficulty: 3,
      //   imagePath: '🚲',
      // ),
    ];
  }
}
