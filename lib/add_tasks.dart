import 'package:flutter/material.dart';
import 'database_management.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController _taskTitleController = TextEditingController();

  void _saveTask() async {
    String taskTitle = _taskTitleController.text.trim();

    if (taskTitle.isNotEmpty) {
      Task newTask = Task(id: null, title: taskTitle, isCompleted: false);
      int? taskId = await DatabaseHelper().insertTask(newTask);

      newTask.id = taskId!;

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskTitleController,
              decoration: InputDecoration(
                labelText: 'Task Title',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveTask,
              child: Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}
