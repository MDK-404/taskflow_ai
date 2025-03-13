// import 'package:flutter/material.dart';
// import '../models/task.dart';
// import '../services/local_storage.dart';

// class TaskProvider with ChangeNotifier {
//   List<Task> _tasks = [];

//   List<Task> get tasks => _tasks;

//   Future<void> loadTasks() async {
//     _tasks = await LocalStorage.loadTasks();
//     _sortTasksByDueDate(); // Sort tasks before displaying
//     notifyListeners();
//   }

//   Future<void> addTask(Task task) async {
//     _tasks.add(task);
//     _sortTasksByDueDate(); // Sort after adding a task
//     await LocalStorage.saveTasks(_tasks);
//     notifyListeners();
//   }

//   Future<void> deleteTask(int index) async {
//     _tasks.removeAt(index);
//     await LocalStorage.saveTasks(_tasks);
//     notifyListeners();
//   }

//   void _sortTasksByDueDate() {
//     _tasks.sort((a, b) =>
//         a.dueDate.compareTo(b.dueDate)); // Sort tasks by nearest due date
//   }
// }

import 'package:flutter/material.dart';
import 'package:taskflow_ai/services/notifications.dart';
import '../models/task.dart';
import '../services/local_storage.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks = await LocalStorage.loadTasks();
    _sortTasksByDueDate();
    _scheduleNotifications(); // Schedule notifications for all tasks
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    _tasks.add(task);
    _sortTasksByDueDate();
    await LocalStorage.saveTasks(_tasks);
    _scheduleNotificationForTask(
        task); // Schedule notification for the new task
    notifyListeners();
  }

  Future<void> deleteTask(int index) async {
    _tasks.removeAt(index);
    await LocalStorage.saveTasks(_tasks);
    notifyListeners();
  }

  void _sortTasksByDueDate() {
    _tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }

  void _scheduleNotifications() {
    for (var task in _tasks) {
      _scheduleNotificationForTask(task);
    }
  }

  void _scheduleNotificationForTask(Task task) {
    DateTime now = DateTime.now();
    DateTime notificationTime = task.dueDate.subtract(Duration(days: 1));

    if (notificationTime.isAfter(now)) {
      NotificationService.scheduleNotification(
        task.title,
        "Task due soon!",
        notificationTime,
      );
    }
  }
}
