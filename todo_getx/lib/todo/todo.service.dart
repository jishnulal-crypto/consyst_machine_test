import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_getx/todo/models/todo.model.dart';

class TodoService {
  CollectionReference todosRef = FirebaseFirestore.instance.collection('todos');
  Stream<Iterable<Todo>> findAll(userId) {
    return todosRef
        .where("user_id", isEqualTo: userId)
        .get()
        .then((QuerySnapshot value) {
      return value.docs
          .map((QueryDocumentSnapshot e) => Todo.fromSnapshot(e))
          .toList();
    }).asStream();
  }

  Future<Todo> findOne(String id) async {
    var result = await todosRef.doc(id).get();
    return Todo.fromSnapshot(result);
  }

  Future<Todo> addOne(String userId, String title, {bool done = false}) async {
    var result =
        await todosRef.add({"user_id": userId, "title": title, "done": done});
    return Todo(id: result.id, title: title, done: done);
  }

  Future<void> updateOne(Todo todo) async {
    await todosRef.doc(todo.id).update(todo.toJson());
  }

  Future<void> deleteOne(String id) async {
    await todosRef.doc(id).delete();
  }
}
