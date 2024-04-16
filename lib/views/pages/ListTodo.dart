// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:todolist/controllers/TodoController.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/views/pages/addTodo.dart';
import 'package:todolist/views/pages/editTodo.dart';

// ignore: must_be_immutable
class ListTodoPage extends StatefulWidget {
  const ListTodoPage({Key? key}) : super(key: key);

  @override
  ListTodoPageState createState() => ListTodoPageState();
}

class ListTodoPageState extends State<ListTodoPage> {
  final title = "Lista de tareas";
  TodoController todoController = TodoController();
  List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    todoController.getTodos().then((todos) {
      setState(() {
        _todos = todos;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey,
      ),
      body: _todos.isEmpty
          ? const Center(child: Text('No hay tareas'))
          : ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                Todo todo = _todos[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Checkbox(
                      value: todo.status,
                      onChanged: (bool? value) {
                        if (todo.id != null) {
                          todoController.updateTodoStatus(todo.id!, value!);
                          setState(() {
                            todo.status = value;
                          });
                        }
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
                            'Fecha límite: ${todo.deadline?.toLocal().toString().split(' ')[0] ?? 'No establecida'}') // Muestra la fecha límite
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize
                          .min, 
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditTodoPage(todo: todo),
                              ),
                            ).then((value){
                              if(value == true){
                                todoController.getTodos().then((todos) {
                                  setState(() {
                                    _todos = todos;
                                  });
                                });
                              }
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            if (todo.id != null) {
                              todoController.deleteTodo(todo.id!).then((_) {
                                setState(() {
                                  _todos.remove(todo);
                                });
                              });
                              
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        backgroundColor: Colors.blueGrey,
        onPressed: () => loadCreateTodoPage(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  loadCreateTodoPage(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const AddTodoPage(),
    ),
  ).then((value) {
    if (value == true) {
      todoController.getTodos().then((todos) {
        setState(() {
          _todos = todos;
        });
      });
    }
  });
}
}


