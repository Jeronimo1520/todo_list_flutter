// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/controllers/TodoProvider.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/views/pages/addTodo.dart';

// ignore: must_be_immutable
class ListTodoPage extends StatelessWidget {
  final title = "Lista de tareas";

  const ListTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          return listTodos(todoProvider);
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10.0, 
        child: const Icon(Icons.add),
        onPressed: () => loadCreateTodoPage(context),
      ),
    );
  }

  ListView listTodos(TodoProvider todoProvider) {
    List<Todo> todos = todoProvider.todos;
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        Todo todo = todos[index];
        return ListTile(
          leading: Checkbox(
            value: todo.status,
            onChanged: (bool? value) {
              todoProvider.updateTodoStatus(todo, value!);
            },
          ),
          title: Text(
            todo.name,
            style: todo.status ?? false
                ? const TextStyle(decoration: TextDecoration.lineThrough)
                : null,
          ),
          subtitle: Text(todo.description,
              style: todo.status ?? false
                  ? const TextStyle(decoration: TextDecoration.lineThrough)
                  : null
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              todoProvider.deleteTodo(todo);
            },
          ),
        );
      },
    );
  }

  loadCreateTodoPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddTodoPage(),
      ),
    );
  }
}
