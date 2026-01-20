import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupedbydate/domain/model/todo.dart';
import 'package:groupedbydate/domain/repo/todo_repo.dart';
import 'package:groupedbydate/presentaion/blocs/todo_event.dart';
import 'package:groupedbydate/presentaion/blocs/todo_state.dart';
import 'package:groupedbydate/presentaion/helper/extension.dart';
import 'package:injectable/injectable.dart';

@injectable
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepo repo;
  TodoBloc(this.repo) : super(TodoInitial()) {
    on<LoadTodoEvent>(_loadTodo);
    on<AddTodoEvent>(_addTodo);
    on<ToggleEvent>(_toggleTodo);
  }

  void _loadTodo(LoadTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      final todos = await repo.getAllTodos();
      emit(TodoLoaded(todos: todos, groupedByDate: _grouoedByDate(todos)));
    } catch (e) {
      emit(TodoMsz(e.toString()));
    }
  }

  void _addTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    try {
      await repo.addTodo(event.todo);
      final todos = await repo.getAllTodos();
      emit(TodoLoaded(todos: todos, groupedByDate: _grouoedByDate(todos)));
    } catch (e) {
      emit(TodoMsz(e.toString()));
    }
  }

  void _toggleTodo(ToggleEvent event, Emitter<TodoState> emit) async {
    try {
      await repo.toggleTodo(event.id);
      final todos = await repo.getAllTodos();
      emit(TodoLoaded(todos: todos, groupedByDate: _grouoedByDate(todos)));
    } catch (e) {
      emit(TodoMsz(e.toString()));
    }
  }

  Map<String, List<Todo>> _grouoedByDate(List<Todo> todos) {
    final Map<String, List<Todo>> grouped = {};

    for (final todo in todos) {
      final key = todo.dateTime.groupedString;
      grouped.putIfAbsent(key, () => []);
      grouped[key]!.add(todo);
    }

    //sort by date descending
    final sortedKeys =
        grouped.keys.toList()..sort((a, b) {
          final aDate = grouped[a]![0].dateTime;
          final bDate = grouped[b]![0].dateTime;
          return bDate.compareTo(aDate);
        });
    final Map<String, List<Todo>> sortedGroup = {};
    for (var key in sortedKeys) {
      sortedGroup[key] = grouped[key]!;
    }
    return sortedGroup;
  }
}
