import 'package:flutter/material.dart';
import 'database_management.dart';

class CompletedTasksTab extends StatefulWidget {
  @override
  _CompletedTasksTabState createState() => _CompletedTasksTabState();
}

class _CompletedTasksTabState extends State<CompletedTasksTab> {
  List<Task> _completedTasks = [];

  @override
  void initState() {
    super.initState();
    _fetchCompletedTasks();
  }

  Future<void> _fetchCompletedTasks() async {
    List<Task> completedTasks = await DatabaseHelper().getCompletedTasks();
    setState(() {
      _completedTasks = completedTasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Tasks'),
      ),
      body: ListView.builder(
        itemCount: _completedTasks.length,
        itemBuilder: (context, index) {
          final task = _completedTasks[index];
          return ListTile(
            title: Text(task.title),
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: null,
            ),
          );
        },
      ),
    );
  }
}
