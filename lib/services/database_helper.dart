import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/todo.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('todos.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL
      )
    ''');
  }

  Future<List<Todo>> getTodos() async {
    final db = await database;
    final result = await db.query('todos');
    return result.map((json) => Todo.fromMap(json)).toList();
  }

  Future<void> addTodo(Todo todo) async {
    final db = await database;
    await db.insert('todos', todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteTodo(int id) async {
    final db = await database;
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
