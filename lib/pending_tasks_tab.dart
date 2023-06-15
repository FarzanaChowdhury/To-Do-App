import 'package:flutter/material.dart';
import 'database_management.dart';

class PendingTasksTab extends StatefulWidget {
  @override
  _PendingTasksTabState createState() => _PendingTasksTabState();
}

class _PendingTasksTabState extends State<PendingTasksTab> {
  List<Task> _pendingTasks = [];

  @override
  void initState() {
    super.initState();
    _fetchPendingTasks();
  }

  Future<void> _fetchPendingTasks() async {
    List<Task> pendingTasks = await DatabaseHelper().getPendingTasks();
    setState(() {
      _pendingTasks = pendingTasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Tasks'),
      ),
      body: ListView.builder(
        itemCount: _pendingTasks.length,
        itemBuilder: (context, index) {
          final task = _pendingTasks[index];
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
