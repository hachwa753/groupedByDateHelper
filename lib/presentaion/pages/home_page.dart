import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupedbydate/domain/model/todo.dart';
import 'package:groupedbydate/presentaion/blocs/todo_bloc.dart';
import 'package:groupedbydate/presentaion/blocs/todo_event.dart';
import 'package:groupedbydate/presentaion/blocs/todo_state.dart';
import 'package:groupedbydate/presentaion/helper/extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<TodoBloc>().add(LoadTodoEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.read<TodoBloc>();
    return Scaffold(
      appBar: AppBar(title: Text("Grouped bu date time")),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is TodoLoaded) {
            if (state.todos.isEmpty) {
              return Center(child: Text("No text found"));
            }
            final grouped = state.groupedByDate;
            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: ListView(
                    children:
                        grouped.entries.map((e) {
                          final date = e.key;
                          final todos = e.value;
                          return Column(
                            children: [
                              Text(date),
                              ...todos.map(
                                (e) => ListTile(
                                  title: Text(e.title.capitalize()),
                                  subtitle: Text(e.dateTime.yMMMMd),
                                  leading: Checkbox(
                                    value: e.isDone,
                                    onChanged: (value) {
                                      todoProvider.add(ToggleEvent(e.id));
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      final todo = state.todos[index];
                      return ListTile(
                        title: Text(todo.title.capitalize()),
                        subtitle: Text(todo.dateTime.yMMMMd),
                        leading: Checkbox(
                          value: todo.isDone,
                          onChanged: (value) {
                            todoProvider.add(ToggleEvent(todo.id));
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DateTime? selectedDate;
          showModalBottomSheet(
            context: context,
            builder:
                (context) => StatefulBuilder(
                  builder: (context, setState) {
                    return Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Add todo"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedDate == null
                                    ? "No date selected"
                                    : selectedDate!.yMMMMd,
                              ),
                              IconButton(
                                onPressed: () async {
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  if (picked != null) {
                                    setState(() {
                                      selectedDate = picked;
                                    });
                                  }
                                },
                                icon: Icon(Icons.calendar_today),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                final todo = Todo(
                                  id:
                                      DateTime.now().millisecondsSinceEpoch
                                          .toString(),
                                  title: "title",

                                  dateTime:
                                      selectedDate != null
                                          ? selectedDate!
                                          : DateTime.now(),
                                );
                                todoProvider.add(AddTodoEvent(todo));
                              },
                              child: Text("Add"),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
          );
          // ScaffoldMessenger.of(
          //   context,
          // ).showSnackBar(SnackBar(content: Text("Success")));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
