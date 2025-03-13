import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Task Manager"),
        backgroundColor: Colors.blue, // AppBar background color
      ),
      body: Container(
        color: Colors.blue[100], // Light blue background
        child: taskProvider.tasks.isEmpty
            ? Center(
                child: Text("No tasks available",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
            : ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: taskProvider.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskProvider.tasks[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2))
                      ],
                    ),
                    child: ListTile(
                      title: Text(task.title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          "Due: ${task.dueDate.toLocal().toString().split(' ')[0]}", // Hide time from date
                          style:
                              TextStyle(fontSize: 16, color: Colors.black54)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () =>
                            _confirmDelete(context, taskProvider, index),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddTaskScreen()),
        ),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _confirmDelete(
      BuildContext context, TaskProvider taskProvider, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Task"),
        content: Text("Are you sure you want to delete this task?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              taskProvider.deleteTask(index);
              Navigator.pop(context);
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
