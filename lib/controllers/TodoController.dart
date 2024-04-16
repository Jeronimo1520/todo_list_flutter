import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/model/todo.dart';

class TodoController{
  FirebaseFirestore db = FirebaseFirestore.instance; //Singleton

  final String collection = "todos";

  // Future<String> create(Map<String,dynamic> todo) async{
  //   DocumentReference response =await db.collection(collection).add(todo);
  //   return response.id;
  // }

  Future<void> deleteTodo(String id) async {
    try {
      await db.collection(collection).doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<List<Todo>> getTodos() async {
  print("Iniciando getTodos");
  List<Todo> todos = [];
  try {
    await db.collection(collection).get().then((querySnapshot) {
      for (var element in querySnapshot.docs) {
        todos.add(Todo(
          id: element.id,
          name: element["name"],
          description: element["description"],
          deadline: element["deadline"] != null ? (element["deadline"] as Timestamp).toDate() : null,
          status: element["status"],
        ));
      }
    });
  } catch (e) {
    print(e);
  }
  print("Finalizando getTodos con ${todos.length} todos");
  return todos;
}

  Future<void> updateTodo(String id, String name, String description, DateTime deadline) async {
    try {
      await db.collection(collection).doc(id).update({
        "name": name,
        "description": description,
        "deadline": deadline,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateTodoStatus(String id, bool status) async {
  await db.collection(collection).doc(id).update({
    'status': status,
  });
}

  Future<void> createTodo(Todo todo) async {
    try {
      await db.collection(collection).add({
        "name": todo.name,
        "description": todo.description,
        "deadline": todo.deadline,
        "status": false
      });
    } catch (e) {
      print(e);
    }
  }

}