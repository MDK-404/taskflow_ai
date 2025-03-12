class Task {
  String title;
  String category;
  DateTime dueDate;
  int priority;

  Task(
      {required this.title,
      required this.category,
      required this.dueDate,
      this.priority = 1});

  Map<String, dynamic> toJson() => {
        'title': title,
        'category': category,
        'dueDate': dueDate.toIso8601String(),
        'priority': priority,
      };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        title: json['title'],
        category: json['category'],
        dueDate: DateTime.parse(json['dueDate']),
        priority: json['priority'],
      );
}
