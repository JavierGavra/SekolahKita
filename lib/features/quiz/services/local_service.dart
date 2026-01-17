import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/database_helper.dart';
import 'package:sekolah_kita/core/database/static/data/numeration_quiz_data.dart';
import 'package:sekolah_kita/core/database/static/data/reading_quiz_data.dart';
import 'package:sekolah_kita/core/database/static/data/writing_quiz_data.dart';
import 'package:sekolah_kita/core/database/static/models/quiz_question_model.dart';

class LocalService {
  List<QuizQuestionModel> getQuestions(CourseType type, int moduleId) {
    return switch (type) {
      CourseType.reading => ReadingQuizData().getQuestion(moduleId),
      CourseType.writing => WritingQuizData().getQuestion(moduleId),
      CourseType.numeration => NumerationQuizData().getQuestion(moduleId),
    };
  }

  Future<void> updateStar(CourseType type, int moduleId) async {
    await DatabaseHelper.instance.addQuizStarsIfNotExists(
      courseType: type,
      moduleId: moduleId,
    );
  }
}
