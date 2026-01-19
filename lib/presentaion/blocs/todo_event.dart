import 'package:groupedbydate/domain/model/todo.dart';

abstract class TodoEvent {}

class LoadTodoEvent extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final Todo todo;

  AddTodoEvent(this.todo);
}

class ToggleEvent extends TodoEvent {
  final String id;

  ToggleEvent(this.id);
}

class DeleteEvent extends TodoEvent {
  final String id;

  DeleteEvent(this.id);
}
