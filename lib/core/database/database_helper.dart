import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("sekolah_kita.db");
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE quiz_stars (
        module_id INTEGER NOT NULL,
        course_type VARCHAR(30) NOT NULL
      )
    ''');
  }

  String courseTypeToString(CourseType type) {
    switch (type) {
      case CourseType.reading:
        return 'reading';
      case CourseType.writing:
        return 'writing';
      case CourseType.numeration:
        return 'numeration';
    }
  }

  Future<void> addQuizStarsIfNotExists({
    required CourseType courseType,
    required int moduleId,
  }) async {
    final course = courseTypeToString(courseType);

    // 1️⃣ cek apakah data sudah ada
    final result = await _database!.query(
      'quiz_stars',
      where: 'module_id = ? AND course_type = ?',
      whereArgs: [moduleId, course],
      limit: 1,
    );

    // 2️⃣ jika sudah ada → tidak lakukan apa-apa
    if (result.isNotEmpty) return;

    // 3️⃣ insert jika belum ada
    await _database!.insert('quiz_stars', {
      'module_id': moduleId,
      'course_type': course,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> getStars() async {
    final result = await _database!.rawQuery('''
    SELECT COUNT(quiz_stars.module_id) as totalStars
    FROM quiz_stars
    ''');

    return (result.first['totalStars'] as int?) ?? 0;
  }

  Future<int> getStarsByCourse({required CourseType courseType}) async {
    final course = courseTypeToString(courseType);

    final result = await _database!.rawQuery(
      '''
    SELECT COUNT(quiz_stars.module_id) as totalStars
    FROM quiz_stars
    WHERE course_type = ?
    ''',
      [course],
    );

    print(result);

    return (result.first['totalStars'] as int?) ?? 0;
  }
}
