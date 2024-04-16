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

  void updateTodo(Todo todo,
      {required String name,
      required String description,
      required DateTime deadline}) {
    int index = _todos.indexOf(todo);
    if (index != -1) {
      _todos[index].name = name;
      _todos[index].description = description;
      _todos[index].deadline = deadline;
      notifyListeners();
    }
    
  }
}
