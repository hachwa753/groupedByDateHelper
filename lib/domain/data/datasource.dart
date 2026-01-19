import 'dart:convert';

import 'package:groupedbydate/domain/model/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Datasource {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  static const _key = 'todos';

  Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      _todos = decoded.map((e) => Todo.fromMap(e)).toList();
    }
    print("LOADED RAW: $jsonString");
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(_todos.map((e) => e.toMap()).toList());
    await prefs.setString(_key, jsonString);
    print("SAVING: $jsonString");
  }

  Future<void> addTodo(Todo todo) async {
    _todos.add(todo);
    await _save();
  }

  Future<void> toggleTodo(String id) async {
    final index = _todos.indexWhere((e) => e.id == id);
    _todos[index] = _todos[index].copyWith(isDone: !_todos[index].isDone);
    await _save();
  }

  Future<void> deleteTodo(String id) async {
    _todos.removeWhere((e) => e.id == id);
    await _save();
  }
}
