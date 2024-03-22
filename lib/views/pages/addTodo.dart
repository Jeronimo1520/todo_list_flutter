import 'package:flutter/material.dart';
import 'package:todolist/controllers/CreateTodoController.dart';
import 'package:todolist/controllers/TodoProvider.dart';
import 'package:provider/provider.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final GlobalKey<FormState> _key = GlobalKey();

  String? name = "";
  String? description = "";
  DateTime? deadline;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar tarea'),
      ),
      body: Consumer<TodoProvider>(
          builder: (context, todoProvider, child) => addTodoForm(todoProvider)),
    );
  }

  Form addTodoForm(TodoProvider todoProvider) {
    return Form(
      key: _key,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              onChanged: (newValue) => name = newValue,
              validator: validatorName,
              decoration: const InputDecoration(
                  labelText: "Nombre",
                  hintText: "Ingrese el nombre de la tarea"),
            ),
            TextFormField(
              onChanged: (newValue) => description = newValue,
              decoration: const InputDecoration(
                  labelText: "Descripcion",
                  hintText: "Ingrese la descripcion de la tarea"),
            ),
            TextButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) deadline = picked;
              },
              child: Text(deadline == null
                  ? "Seleccionar fecha límite"
                  : "Fecha límite: ${deadline.toString()}"),
            ),
            TextButton(
              onPressed: () {
                if (_key.currentState!.validate()) {
                  saveTodo(_key,
                      name: name,
                      description: description,
                      provider: todoProvider,
                      deadline: deadline);
                      Navigator.pop(context);
                }
              },
              child: const Text("Guardar tarea"),
            )
          ],
        ),
      ),
    );
  }
}