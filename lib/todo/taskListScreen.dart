import 'package:flutter/material.dart';
import 'package:to_do_application/todo/addTaskScreen.dart';
import 'package:to_do_application/todo/dbHelper.dart';
import 'package:to_do_application/todo/task.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  void _loadTasks() async {
    final data = await DBHelper.getTasks();
    setState(() => tasks = data);
  }

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Tasks")),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (ctx, i) {
          final task = tasks[i];
          return ListTile(
            title: Text(task.title),
            subtitle: Text('${task.date} @ ${task.time}\n${task.note}'),
            isThreeLine: true,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddTaskScreen(
                        task: task,
                        onTaskAdded: _loadTasks,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await DBHelper.deleteTask(task.id!);
                    _loadTasks();
                  },
                ),
              ],
            ),
          );

        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddTaskScreen(onTaskAdded: _loadTasks),
          ),
        ),
      ),
    );
  }
}
