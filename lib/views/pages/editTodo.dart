import 'package:flutter/material.dart';
import 'package:todolist/controllers/TodoController.dart';
import 'package:todolist/model/todo.dart';

class EditTodoPage extends StatefulWidget {
  final Todo todo;

  const EditTodoPage({Key? key, required this.todo}) : super(key: key);

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final GlobalKey<FormState> _key = GlobalKey();

  late String name;
  late String description;
  late DateTime deadline;
  late String id;

  TodoController todoController = TodoController();

  @override
  void initState() {
    super.initState();
    id = widget.todo.id!;
    name = widget.todo.name;
    description = widget.todo.description;
    deadline = widget.todo.deadline!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar tarea'),
      ),
      body: editTodoForm(todoController)
    );
  }

  Form editTodoForm(TodoController todoController) {
    return Form(
      key: _key,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: name,
              onChanged: (newValue) => name = newValue,
              decoration: const InputDecoration(
                  labelText: "Nombre",
                  hintText: "Ingrese el nombre de la tarea"),
            ),
            TextFormField(
              initialValue: description,
              onChanged: (newValue) => description = newValue,
              decoration: const InputDecoration(
                  labelText: "Descripcion",
                  hintText: "Ingrese la descripcion de la tarea"),
            ),
            TextButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: deadline,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) deadline = picked;
              },
              child: Text(deadline.toLocal().toString().split(' ')[0]),
            ),
            ElevatedButton(
              onPressed: () {
                if (_key.currentState!.validate()) {
                  _key.currentState!.save();
                  todoController.updateTodo(widget.todo.id!,
                       name,description,deadline);
                  Navigator.pop(context, true);
                }
              },
              child: const Text('Guardar'),
            )
          ],
        ),
      ),
    );
  }
}
