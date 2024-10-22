import 'package:flutter_application_1/features/user/data/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
        CREATE TABLE $tableNameField(
          $idField INTEGER PRIMARY KEY AUTOINCREMENT,
          $nameField TEXT,
          $emailField TEXT
        )
        ''');
      },
    );
  }

  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert(tableNameField, user.toMap());
  }
}
