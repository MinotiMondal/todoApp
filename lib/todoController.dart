import 'package:get/get.dart';
import 'package:todoapp/taskModel.dart';



class TodoController extends GetxController {

  var tasks = <Task>[].obs;

  void addTask(String title) {
    tasks.add(Task(title: title));
  }

  void toggleTaskStatus(int index) {
    tasks[index].isCompleted = !tasks[index].isCompleted;
    tasks.refresh();
  }

}
