import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = "Work";

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _saveTask() {
    if (_titleController.text.isEmpty) return;

    Task newTask = Task(
      title: _titleController.text,
      category: _selectedCategory,
      dueDate: _selectedDate,
    );

    Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: InputDecoration(labelText: "Task Title")),
            DropdownButton<String>(
              value: _selectedCategory,
              items: ["Work", "Study", "Personal"].map((category) {
                return DropdownMenuItem(value: category, child: Text(category));
              }).toList(),
              onChanged: (value) => setState(() => _selectedCategory = value!),
            ),
            Row(
              children: [
                Text("Due Date: ${_selectedDate.toLocal()}".split(' ')[0]),
                IconButton(icon: Icon(Icons.calendar_today), onPressed: _pickDate),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _saveTask, child: Text("Save Task")),
          ],
        ),
      ),
    );
  }
}
