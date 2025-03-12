import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_ai/screens/homw_screen.dart';
import 'package:taskflow_ai/services/notifications.dart';
import 'providers/task_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider()..loadTasks(),
      child: MaterialApp(
        title: 'Task Manager',
        home: HomeScreen(),
      ),
    );
  }
}
