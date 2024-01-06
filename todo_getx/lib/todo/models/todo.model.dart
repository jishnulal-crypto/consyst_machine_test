import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String? id;
  String? title;
  bool? done;
  String? userId;
  Todo({this.id, this.userId, this.title, this.done = false});
  copyWith({title, done}) {
    return Todo(
      id: id,
      title: title ?? this.title,
      userId: userId ?? this.userId,
      done: done ?? this.done,
    );
  }

  factory Todo.fromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic>? data = snap.data() as Map<String, dynamic>?;

    return Todo(
      id: snap.id,
      done: data?["done"] ?? false, // Provide a default value if 'done' is null
      title: data?['title'] ?? '', // Provide a default value if 'title' is null
    );
  }

  toJson() {
    return {"title": title, "done": done};
  }
}
