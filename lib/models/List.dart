import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskverse/models/Task.dart';

class Array {
  String? title;
  String? id;
  Timestamp? dateCreated;
  List<Task>? task;

  Array({this.title, this.id, this.dateCreated, this.task});

  Array.fromMap(DocumentSnapshot doc) {
    title = doc["title"];
    id = doc.id;
    dateCreated = doc["dateCreated"];
    task =
        doc['task'].map<Task>((mapString) => Task.fromJson(mapString)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateCreated': dateCreated,
      'title': title,
      'task': task!.map((todo) => todo.toJson()).toList(),
    };
  }
}
