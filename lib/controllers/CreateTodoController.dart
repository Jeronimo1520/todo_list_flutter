import 'package:flutter/material.dart';
import 'package:todolist/controllers/TodoProvider.dart';
import 'package:todolist/model/todo.dart';

String? validatorName(String? name) {
  if (name == null || name.isEmpty) {
    return "El nombre es obligatorio";
  }
  return null;
}

saveTodo(GlobalKey<FormState> _key,
    {required String? name, required String? description,  required TodoProvider provider, required DateTime? deadline}) {
  if (_key.currentState!.validate()) {
    _key.currentState!.save();
    if (name != null && description != null) {
      Todo contact = Todo(name: name, description: description, status: false, deadline: deadline );
      provider.addTodo(contact);
    }
  }
}