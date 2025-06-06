import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_application/new/taskController.dart';
import 'package:to_do_application/new/taskModel.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;
  EditTaskPage({required this.task});
///////kkkkkk
  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  //hello
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final TaskController _taskController = Get.find();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task.title;
    _noteController.text = widget.task.note;
    _selectedDate = DateFormat.yMd().parse(widget.task.date);
    final timeParts = widget.task.time.split(":");
    _selectedTime = TimeOfDay(
      hour: int.parse(timeParts[0]),
      minute: int.parse(timeParts[1]),
    );
  }

  void _submit() {
    if (_titleController.text.isEmpty || _noteController.text.isEmpty || _selectedDate == null || _selectedTime == null) {
      Get.snackbar('Error', 'All fields are required');
      return;
    }

    final updatedTask = Task(
      id: widget.task.id,
      title: _titleController.text,
      note: _noteController.text,
      date: DateFormat.yMd().format(_selectedDate!),
      time: _selectedTime!.format(context),
    );

    _taskController.updateTask(updatedTask);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(          backgroundColor: Colors.deepPurpleAccent,
          title: Text('Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: const Text("Task Title",style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),)),
            const SizedBox(height: 10,),
            TextField(controller: _titleController, decoration: InputDecoration( border: OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.teal)
            ),labelText: 'Title')),
            const SizedBox(height: 10,),

            Align(
                alignment: Alignment.topLeft,

                child: const Text("Note",style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),)),
            SizedBox(height: 10,),
            TextField(controller: _noteController, decoration: InputDecoration( border: OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.teal)
            ),labelText: 'Note')),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: Text(_selectedDate == null ? 'No Date' : DateFormat.yMd().format(_selectedDate!))),
                TextButton(
                  child: Text('Choose Date'),
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate ?? DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() {
                        _selectedDate = picked;
                      });
                    }
                  },
                )
              ],
            ),
            Row(
              children: [
                Expanded(child: Text(_selectedTime == null ? 'No Time' : _selectedTime!.format(context))),
                TextButton(
                  child: Text('Choose Time'),
                  onPressed: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: _selectedTime ?? TimeOfDay.now(),
                    );
                    if (picked != null) {
                      setState(() {
                        _selectedTime = picked;
                      });
                    }
                  },
                )
              ],
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(  style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent, // Button color
                foregroundColor: Colors.white, // Text color
              ),onPressed: _submit, child: Text('Update Task')),
            ),
          ],
        ),
      ),
    );
  }
}
