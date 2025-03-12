import '../models/task.dart';

class TaskPriority {
  static void prioritizeTasks(List<Task> tasks) {
    tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    for (int i = 0; i < tasks.length; i++) {
      tasks[i].priority = i + 1;
    }
  }
}
