import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupedbydate/domain/model/todo.dart';
import 'package:groupedbydate/presentaion/blocs/todo_bloc.dart';
import 'package:groupedbydate/presentaion/blocs/todo_event.dart';
import 'package:groupedbydate/presentaion/blocs/todo_state.dart';
import 'package:groupedbydate/presentaion/helper/extension.dart';

class Groupedbydate extends StatelessWidget {
  const Groupedbydate({super.key});

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.read<TodoBloc>();
    return Scaffold(
      appBar: AppBar(title: Text("Grouped by date in listview builder")),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is TodoLoaded) {
            if (state.groupedByDate.isEmpty) {
              Center(child: Text("Empty"));
            }
            // Convert grouped map into a flat list with headers
            final items = [];
            state.groupedByDate.forEach((date, todos) {
              items.add(date); //header
              items.addAll(todos);
            });

            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                if (item is String) {
                  return Center(child: Text(item));
                }
                final todo = item as Todo;
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
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
