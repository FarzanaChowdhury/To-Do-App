import 'package:flutter/material.dart';

import 'database_management.dart';


class AllTasksTab extends StatefulWidget {
  @override
  _AllTasksTabState createState() => _AllTasksTabState();
}

class _AllTasksTabState extends State<AllTasksTab> {
  static DatabaseHelper? _databaseHelper;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Tasks'),
      ),
      body: FutureBuilder<List<Task>>(
        future: _databaseHelper!.getAllTasks(),
        builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final tasks = snapshot.data;

            if (tasks!.isEmpty) {
              return Center(
                child: Text('No tasks.'),
              );
            }

            return ListView.builder(
              itemCount: tasks?.length,
              itemBuilder: (BuildContext context, int index) {
                final task = tasks?[index];

                return ListTile(
                  title: Text(task!.title),
                  leading: Checkbox(
                    value: task?.isCompleted,
                    onChanged: (value) {
                      setState(() {
                        task.isCompleted = value!;
                        _databaseHelper?.updateTaskCompletion(task.id, value);
                      });
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Code to navigate to the page where the user can add a task
          Navigator.pushNamed(context, '/add_task');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
