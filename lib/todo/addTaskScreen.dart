import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_application/todo/task.dart';

import 'dbHelper.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? task; // If null, it's a new task

  final VoidCallback onTaskAdded;
  const AddTaskScreen({this.task, required this.onTaskAdded, super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  void _submit() async {
    if (_titleController.text.isEmpty ||
        _selectedDate == null ||
        _selectedTime == null) return;

    final task = Task(
      id: widget.task?.id,
      title: _titleController.text,
      date: DateFormat.yMd().format(_selectedDate!),
      time: _selectedTime!.format(context),
      note: _noteController.text,
    );

    if (widget.task == null) {
      await DBHelper.insertTask(task);
    } else {
      await DBHelper.updateTask(task);
    }

    widget.onTaskAdded();
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _noteController.text = widget.task!.note;
      _selectedDate = DateFormat.yMd().parse(widget.task!.date);
      final time = widget.task!.time.split(":");
      _selectedTime = TimeOfDay(
          hour: int.parse(time[0]), minute: int.parse(time[1].split(" ")[0]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title')),
            TextField(
                controller: _noteController,
                decoration: const InputDecoration(labelText: 'Note')),
            Row(
              children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? 'No date chosen!'
                      : DateFormat.yMd().format(_selectedDate!)),
                ),
                TextButton(
                  child: Text('Choose Date'),
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null)
                      setState(() => _selectedDate = pickedDate);
                  },
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(_selectedTime == null
                      ? 'No time chosen!'
                      : _selectedTime!.format(context)),
                ),
                TextButton(
                  child: Text('Choose Time'),
                  onPressed: () async {
                    final pickedTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    if (pickedTime != null)
                      setState(() => _selectedTime = pickedTime);
                  },
                )
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _submit, child: Text('Add Task'))
          ],
        ),
      ),
    );
  }
}
