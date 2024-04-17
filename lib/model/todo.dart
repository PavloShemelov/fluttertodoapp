import 'package:cloud_firestore/cloud_firestore.dart';

class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'todoText': todoText,
      'isDone': isDone,
    };
  }

  factory ToDo.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ToDo(
      id: doc.id,
      todoText: data['todoText'],
      isDone: data['isDone'],
    );
  }
}