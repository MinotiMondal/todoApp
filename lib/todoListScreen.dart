import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/todoController.dart';

class TodoListScreen extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());
  final TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List', style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w500
        ),),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: taskController,
                    decoration: InputDecoration(

                       enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(20),
                           borderSide: BorderSide(
                               color: Colors.green
                           )
                       ),
                       focusedBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(20),
                           borderSide: BorderSide(
                               color: Colors.blue
                           )
                       ),
                      labelText: 'Add a task',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (taskController.text.trim().isNotEmpty) {
                      todoController.addTask(taskController.text.trim());
                      taskController.clear();
                    }

                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
                  () => ListView.builder(
                itemCount: todoController.tasks.length,
                itemBuilder: (context, index) {
                  final task = todoController.tasks[index];
                  return ListTile(
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (_) {
                        todoController.toggleTaskStatus(index);
                      },
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.isCompleted
                            ? TextDecoration.none
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

