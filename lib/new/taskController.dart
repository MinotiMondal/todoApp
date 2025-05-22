import 'package:get/get.dart';
import 'package:to_do_application/new/db_Helper.dart';
import 'package:to_do_application/new/taskModel.dart';

class TaskController extends GetxController {
  var taskList = <Task>[].obs;
  final DBHelper _dbHelper = DBHelper();

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void fetchTasks() async {
    taskList.value = await _dbHelper.getTasks();
  }

  void addTask(Task task) async {
    await _dbHelper.insertTask(task);
    fetchTasks();
  }

  void deleteTask(int id) async {
    await _dbHelper.deleteTask(id);
    fetchTasks();
  }
  void updateTask(Task task) async {
    await _dbHelper.updateTask(task);
    fetchTasks();
  }
  void toggleTaskCompleted(Task task) {
    Task updatedTask = Task(
      id: task.id,
      title: task.title,
      note: task.note,
      date: task.date,
      time: task.time,
      completed: !task.completed,
    );

    updateTask(updatedTask);
  }

}
