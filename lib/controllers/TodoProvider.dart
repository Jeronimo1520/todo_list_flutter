import 'package:todolist/model/todo.dart';
import 'package:flutter/foundation.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  deleteTodo(Todo todo) {
     _todos.remove(todo);
    notifyListeners();
  }

  void updateTodoStatus(Todo todo, bool status) {
  todo.status = status;
  notifyListeners();
}
}
