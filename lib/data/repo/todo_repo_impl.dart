import 'package:groupedbydate/domain/data/datasource.dart';
import 'package:groupedbydate/domain/model/todo.dart';
import 'package:groupedbydate/domain/repo/todo_repo.dart';

class TodoRepoImpl implements TodoRepo {
  final Datasource datasource;
  TodoRepoImpl(this.datasource);
  @override
  Future<List<Todo>> getAllTodos() async {
    return datasource.todos;
  }

  @override
  Future<void> addTodo(Todo todo) async {
    return datasource.addTodo(todo);
  }

  @override
  Future<void> deleteTodo(String id) async {
    return datasource.deleteTodo(id);
  }

  @override
  Future<void> toggleTodo(String id) async {
    return datasource.toggleTodo(id);
  }
}
