// import 'package:flutter/material.dart';
// import 'package:your_app_name/database_helper.dart';
//
// import 'database_management.dart';
//
// class CompletedTasksTab extends StatefulWidget {
//   @override
//   _CompletedTasksTabState createState() => _CompletedTasksTabState();
// }
//
// class _CompletedTasksTabState extends State<CompletedTasksTab> {
//   static DatabaseHelper? _databaseHelper;
//
//   @override
//   void initState() {
//     super.initState();
//     _databaseHelper = DatabaseHelper();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Completed Tasks'),
//       ),
//       body: FutureBuilder<List<Task>>(
//         future: _databaseHelper.getCompletedTasks(),
//         builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             final tasks = snapshot.data;
//
//             if (tasks.isEmpty) {
//               return Center(
//                 child: Text('No completed tasks.'),
//               );
//             }
//
//             return ListView.builder(
//               itemCount: tasks.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final task = tasks[index];
//
//                 return ListTile(
//                   title: Text(task.title),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
