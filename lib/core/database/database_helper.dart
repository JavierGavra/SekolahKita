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
    // EXAMPLE
    // await db.execute('''
    //   CREATE TABLE tags (
    //     id INTEGER PRIMARY KEY AUTOINCREMENT,
    //     title VARCHAR(30) NOT NULL,
    //     background_hex TEXT NOT NULL,
    //     background_dark_status BOOLEAN NOT NULL
    //   )
    // ''');
  }
}