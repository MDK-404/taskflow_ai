import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/local_storage.dart';
import '../services/task_priority.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks = await LocalStorage.loadTasks();
    TaskPriority.prioritizeTasks(_tasks);
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    _tasks.add(task);
    await LocalStorage.saveTasks(_tasks);
    notifyListeners();
  }

  Future<void> deleteTask(int index) async {
    _tasks.removeAt(index);
    await LocalStorage.saveTasks(_tasks);
    notifyListeners();
  }
}
