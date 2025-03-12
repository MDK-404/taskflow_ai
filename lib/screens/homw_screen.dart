// import 'package:flutter/material.dart';
// import '../models/task.dart';
// import '../services/local_storage.dart';
// import 'add_task_screen.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<Task> tasks = [];

//   @override
//   void initState() {
//     super.initState();
//     loadTasks();
//   }

//   void loadTasks() async {
//     tasks = await LocalStorage.loadTasks();
//     setState(() {});
//   }

//   void navigateToAddTask() async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => AddTaskScreen()),
//     );
//     if (result == true) loadTasks();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Task Manager")),
//       body: tasks.isEmpty
//           ? Center(child: Text("No tasks available"))
//           : ListView.builder(
//               itemCount: tasks.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(tasks[index].title),
//                   subtitle: Text("Due: ${tasks[index].dueDate.toLocal()}"),
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: navigateToAddTask,
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Task Manager")),
      body: taskProvider.tasks.isEmpty
          ? Center(child: Text("No tasks available"))
          : ListView.builder(
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text("Due: ${task.dueDate.toLocal()}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => taskProvider.deleteTask(index),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddTaskScreen()),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
