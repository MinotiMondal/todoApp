import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:to_do_application/new/taskModel.dart';

class DBHelper {

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'task.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute('''
        CREATE TABLE tasks(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          note TEXT,
          date TEXT,
          time TEXT,
          completed INTEGER

        )
      ''');
    });
  }

  Future<int> insertTask(Task task) async {
    final dbClient = await db;
    return await dbClient.insert('tasks', task.toMap());
  }

  Future<List<Task>> getTasks() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query('tasks');
    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }

  Future<int> deleteTask(int id) async {
    final dbClient = await db;
    return await dbClient.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateTask(Task task) async {
    final dbClient = await db;
    return await dbClient.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

}
