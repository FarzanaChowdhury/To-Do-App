import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    String path = await getDatabasesPath();
    String databasePath = join(path, 'your_app_database.db');

    return await openDatabase(
      databasePath,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        isCompleted INTEGER
      )
    ''');
  }

  Future<List<Task>> getAllTasks() async {
    Database? db = await database;
    List<Map<String, Object?>>? taskMaps = await db?.query('tasks');
    return List.generate(taskMaps!.length, (index) {
      return Task.fromMap(taskMaps[index]);
    });
  }

  Future<int?> insertTask(Task task) async {
    Database? db = await database;
    return await db?.insert('tasks', task.toMap());
  }

  Future<int?> updateTaskCompletion(int? taskId, bool isCompleted) async {
    Database? db = await database;
    return await db?.update(
      'tasks',
      {'isCompleted': isCompleted ? 1 : 0},
      where: 'id = ?',
      whereArgs: [taskId ?? -1], // Use a default value (-1) if taskId is null
    );
  }
  Future<List<Task>> getCompletedTasks() async {
    Database? db = await database;
    List<Map<String, Object?>>? maps = await db?.query('tasks', where: 'isCompleted = ?', whereArgs: [1]);
    return List.generate(maps!.length, (index) => Task.fromMap(maps[index]));
  }

  Future<List<Task>> getPendingTasks() async {
    Database? db = await database;
    List<Map<String, Object?>>? maps = await db?.query('tasks', where: 'isCompleted = ?', whereArgs: [0]);
    return List.generate(maps!.length, (index) => Task.fromMap(maps[index]));
  }

}


class Task {
  int? id;
  String title;
  bool isCompleted;

  Task({this.id, required this.title, required this.isCompleted});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}
