import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_application/new/addTask.dart';
import 'package:to_do_application/new/editTaskPage.dart';
import 'package:to_do_application/new/taskController.dart';

class TaskListPage extends StatelessWidget {
  final TaskController _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurpleAccent,title: const Text('To-Do List',style: TextStyle(fontWeight: FontWeight.w400),)),
      body: Obx(() {
        if (_taskController.taskList.isEmpty) {
          return FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 500)), // simulate loading
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Center(child: Text('No tasks'));
              }
            },
          );
        }
        return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (context, index) {
            final task = _taskController.taskList[index];
            return ListTile(
              title: Text(task.title),
              subtitle: Text('${task.note}\n${task.date} ${task.time}'),
              isThreeLine: true,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => Get.to(() => EditTaskPage(task: task)),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _taskController.deleteTask(task.id!),
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddTaskPage()),
        child: const Icon(Icons.add, color: Colors.purple,),
      ),
    );
  }
}
