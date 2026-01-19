import 'package:groupedbydate/domain/model/todo.dart';

abstract class TodoRepo {
  Future<List<Todo>> getAllTodos();
  Future<void> addTodo(Todo todo);
  Future<void> deleteTodo(String id);
  Future<void> toggleTodo(String id);
}
