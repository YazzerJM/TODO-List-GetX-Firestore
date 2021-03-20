import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/todo.dart';

class Database {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTodo(String todo) async {
    try {
      await _firestore
        .collection('todos')
        .add({
          'createdAt' : Timestamp.now(),
          'finished' : false,
          'todo' : todo
        });
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> finishTodo(Todo todo) async {
    try{
      await _firestore
      .collection('todos')
      .doc(todo.todoId)
      .update({
        'finished' : !todo.finished
      });
    }catch(error){
      print(error);
      rethrow;
    }
  }

  Future<void> deleteTodo(Todo todo) async {
    try {
      await _firestore
        .collection('todos')
        .doc(todo.todoId)
        .delete();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  // Escuchamos todo cambio de datos en la coleccion. 
  
  Stream<List<Todo>> todoStream(){
    return _firestore
      .collection('todos')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((QuerySnapshot query){
        List<Todo> retVal = <Todo>[];
        query.docs.forEach((element) {
          retVal.add(Todo.fromDocumentSnapshot(element));
        });
        
        return retVal;
      });
  }

}