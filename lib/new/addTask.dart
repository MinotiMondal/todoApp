import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_application/new/taskController.dart';
import 'package:to_do_application/new/taskModel.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final TaskController _taskController = Get.find();

  void _submit() {
    if (_titleController.text.isEmpty || _noteController.text.isEmpty || _selectedDate == null || _selectedTime == null) {
      Get.snackbar('Error', 'All fields are required');
      return;
    }

    final newTask = Task(
      title: _titleController.text,
      note: _noteController.text,
      date: DateFormat.yMd().format(_selectedDate!),
      time: _selectedTime!.format(context),
    );

    _taskController.addTask(newTask);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: InputDecoration(labelText: 'Title')),
            TextField(controller: _noteController, decoration: InputDecoration(labelText: 'Note')),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(_selectedDate == null ? 'No Date Chosen' : DateFormat.yMd().format(_selectedDate!)),
                ),
                TextButton(
                  child: Text('Choose Date'),
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() {
                        _selectedDate = picked;
                      });
                    }
                  },
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(_selectedTime == null ? 'No Time Chosen' : _selectedTime!.format(context)),
                ),
                TextButton(
                  child: Text('Choose Time'),
                  onPressed: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (picked != null) {
                      setState(() {
                        _selectedTime = picked;
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 24),
            ElevatedButton(onPressed: _submit, child: Text('Add Task')),
          ],
        ),
      ),
    );
  }
}
