
import 'package:get/get.dart';
import '../models/todo.dart';
import '../services/database.dart';

class TodoController extends GetxController {

  // Va a estar escuchando los datos de tipo lista que a su vez los datos de tipo Todo
  Rx<List<Todo>> todoList = Rx<List<Todo>>();


  List<Todo> get todos => todoList.value;

  @override
  void onInit(){
    todoList.bindStream(Database().todoStream());
  }

}