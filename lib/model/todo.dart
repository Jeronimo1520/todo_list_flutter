// import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String? id;
  String name;
  String description;
  bool? status;
  DateTime? deadline;

  Todo({required this.name, required this.description, required this.status, required this.deadline, this.id});
  Todo.fromJson(Map<String, dynamic> json,String idTask)
      : id = idTask,
        name = json['name'],
        description = json['description'],
        status = json['done'],
        deadline = json['deadline'];   
}