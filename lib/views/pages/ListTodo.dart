// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/controllers/TodoProvider.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/views/pages/addTodo.dart';
import 'package:todolist/views/pages/editTodo.dart';

// ignore: must_be_immutable
class ListTodoPage extends StatelessWidget {
  final title = "Lista de tareas";

  const ListTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey,
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          return ListView.builder(
            itemCount: todoProvider.todos.length,
            itemBuilder: (context, index) {
              Todo todo = todoProvider.todos[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Checkbox(
                    value: todo.status,
                    onChanged: (bool? value) {
                      todoProvider.updateTodoStatus(todo, value!);
                    },
                  ),
                  title: Text(
                    todo.name,
                    style: todo.status ?? false
                        ? const TextStyle(
                            decoration: TextDecoration.lineThrough)
                        : null,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(todo.description),
                      Text(
                          'Fecha límite: ${todo.deadline?.toLocal().toString().split(' ')[0] ?? 'No establecida'}') // Muestra la fecha límite aquí
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize
                        .min, // Esto asegura que la fila no ocupe todo el espacio disponible
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditTodoPage(todo: todo),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          todoProvider.deleteTodo(todo);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueGrey,
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
                  : null),
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
