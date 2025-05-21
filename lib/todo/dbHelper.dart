import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:to_do_application/todo/task.dart';

class DBHelper {
  static Future<Database> _getDB() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'task.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            date TEXT,
            time TEXT,
            note TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  static Future<int> insertTask(Task task) async {
    final db = await _getDB();
    return db.insert('tasks', task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Task>> getTasks() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }

  static Future<void> deleteTask(int id) async {
    final db = await _getDB();
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
  static Future<int> updateTask(Task task) async {
    final db = await _getDB();
    return db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

}
