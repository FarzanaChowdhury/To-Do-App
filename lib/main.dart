import 'package:flutter/material.dart';
import 'all_tasks_tab.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Your App Name',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      // home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Widget> tabs = [
    AllTasksTab(),
    // CompletedTasksTab(),
    // PendingTasksTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your App Name'),
      ),
      body: tabs[0], // Displaying the first tab initially
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'All Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            label: 'Completed Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pending),
            label: 'Pending Tasks',
          ),
        ],
        currentIndex: 0, // Set the initial index
        onTap: (int index) {
          // Update the body based on the selected tab
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return tabs[index];
          }));
        },
      ),
    );
  }
}
