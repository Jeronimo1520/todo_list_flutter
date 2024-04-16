import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:todolist/controllers/TodoProvider.dart';
import 'package:todolist/firebase_options.dart';
import 'package:todolist/views/pages/ListTodo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  ).then((value) => runApp(const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:  ListTodoPage(),
      ),
    );
  }
}
