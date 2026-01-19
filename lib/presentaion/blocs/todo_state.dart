import 'package:groupedbydate/domain/model/todo.dart';

abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;
  final Map<String, List<Todo>> groupedByDate;
  TodoLoaded({required this.todos, required this.groupedByDate});
}

class TodoMsz extends TodoState {
  final String msz;

  TodoMsz(this.msz);
}
