import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/controllers/TodoProvider.dart';
import 'package:todolist/views/pages/ListTodo.dart';

void main() {
   runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TodoProvider()),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:  ListTodoPage(),
      ),
    );
  }
}
