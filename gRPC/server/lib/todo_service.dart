import 'dart:math';

import 'package:protos/protos.dart';

class TodoService extends TodoServiceBase {
  @override
  Future<Todo> getTodo(ServiceCall call, GetTodoByIdRequest request) async {
    final id = request.id;
    final todo = Todo(id: id, title: 'title $id', completed: false);
    return todo;
  }

  @override
  Stream<Todo> getTodoStream(
      ServiceCall call, GetTodoByIdRequest request) async* {
    for(int i = 1; i <= 2000; i++ ) {
      final id = i;
      final todo = Todo(id: id, title: 'title $id', completed: false);
      print("Emitting: ${todo.id}");
      yield todo;
      await Future.delayed(Duration(milliseconds: Random().nextInt(10)));
    }
  }
}
