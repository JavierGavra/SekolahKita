// lib/features/quiz/models/quiz_models.dart

class Quiz {
  final String id;
  final String courseId;
  final String moduleId;
  final String title;
  final String description;
  final int totalQuestions;
  final int timeLimit; // in minutes
  final int passingScore;
  final List<String> questionTypes;
  final List<String> rules;
  final List<Question> questions;

  Quiz({
    required this.id,
    required this.courseId,
    required this.moduleId,
    required this.title,
    required this.description,
    required this.totalQuestions,
    required this.timeLimit,
    required this.passingScore,
    required this.questionTypes,
    required this.rules,
    required this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      courseId: json['courseId'],
      moduleId: json['moduleId'],
      title: json['title'],
      description: json['description'],
      totalQuestions: json['totalQuestions'],
      timeLimit: json['timeLimit'],
      passingScore: json['passingScore'],
      questionTypes: List<String>.from(json['questionTypes']),
      rules: List<String>.from(json['rules']),
      questions: (json['questions'] as List)
          .map((q) => Question.fromJson(q))
          .toList(),
    );
  }
}

class Question {
  final String id;
  final int number;
  final String text;
  final QuestionType type;
  final String? imageUrl;
  final List<AnswerOption> options;
  final String correctAnswerId;

  Question({
    required this.id,
    required this.number,
    required this.text,
    required this.type,
    this.imageUrl,
    required this.options,
    required this.correctAnswerId,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      number: json['number'],
      text: json['text'],
      type: QuestionType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      imageUrl: json['imageUrl'],
      options: (json['options'] as List)
          .map((o) => AnswerOption.fromJson(o))
          .toList(),
      correctAnswerId: json['correctAnswerId'],
    );
  }
}

class AnswerOption {
  final String id;
  final String text;

  AnswerOption({required this.id, required this.text});

  factory AnswerOption.fromJson(Map<String, dynamic> json) {
    return AnswerOption(id: json['id'], text: json['text']);
  }
}

enum QuestionType { multipleChoice, trueFalse, multipleAnswer }

class QuizAnswer {
  final String questionId;
  final List<String> selectedOptionIds;
  final DateTime answeredAt;

  QuizAnswer({
    required this.questionId,
    required this.selectedOptionIds,
    required this.answeredAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'selectedOptionIds': selectedOptionIds,
      'answeredAt': answeredAt.toIso8601String(),
    };
  }
}

class QuizResult {
  final String quizId;
  final int score;
  final bool passed;
  final int correctAnswers;
  final int wrongAnswers;
  final int totalQuestions;
  final Duration timeUsed;
  final List<QuestionResult> questionResults;
  final DateTime completedAt;

  QuizResult({
    required this.quizId,
    required this.score,
    required this.passed,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.totalQuestions,
    required this.timeUsed,
    required this.questionResults,
    required this.completedAt,
  });

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      quizId: json['quizId'],
      score: json['score'],
      passed: json['passed'],
      correctAnswers: json['correctAnswers'],
      wrongAnswers: json['wrongAnswers'],
      totalQuestions: json['totalQuestions'],
      timeUsed: Duration(seconds: json['timeUsedSeconds']),
      questionResults: (json['questionResults'] as List)
          .map((qr) => QuestionResult.fromJson(qr))
          .toList(),
      completedAt: DateTime.parse(json['completedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quizId': quizId,
      'score': score,
      'passed': passed,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
      'totalQuestions': totalQuestions,
      'timeUsedSeconds': timeUsed.inSeconds,
      'questionResults': questionResults.map((qr) => qr.toJson()).toList(),
      'completedAt': completedAt.toIso8601String(),
    };
  }
}

class QuestionResult {
  final String questionId;
  final int questionNumber;
  final String questionText;
  final bool isCorrect;
  final List<String> selectedOptionIds;
  final String correctAnswerId;
  final List<AnswerOption> options;

  QuestionResult({
    required this.questionId,
    required this.questionNumber,
    required this.questionText,
    required this.isCorrect,
    required this.selectedOptionIds,
    required this.correctAnswerId,
    required this.options,
  });

  factory QuestionResult.fromJson(Map<String, dynamic> json) {
    return QuestionResult(
      questionId: json['questionId'],
      questionNumber: json['questionNumber'],
      questionText: json['questionText'],
      isCorrect: json['isCorrect'],
      selectedOptionIds: List<String>.from(json['selectedOptionIds']),
      correctAnswerId: json['correctAnswerId'],
      options: (json['options'] as List)
          .map((o) => AnswerOption.fromJson(o))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'questionNumber': questionNumber,
      'questionText': questionText,
      'isCorrect': isCorrect,
      'selectedOptionIds': selectedOptionIds,
      'correctAnswerId': correctAnswerId,
      'options': options.map((o) => {'id': o.id, 'text': o.text}).toList(),
    };
  }
}
