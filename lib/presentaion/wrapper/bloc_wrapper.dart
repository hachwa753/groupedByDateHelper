import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupedbydate/data/repo/todo_repo_impl.dart';
import 'package:groupedbydate/domain/data/datasource.dart';
import 'package:groupedbydate/presentaion/blocs/todo_bloc.dart';
import 'package:groupedbydate/presentaion/blocs/todo_event.dart';
import 'package:groupedbydate/presentaion/pages/root_screen.dart';

class BlocWrapper extends StatelessWidget {
  final Datasource datasource;
  const BlocWrapper({super.key, required this.datasource});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Datasource().loadTodos(),
      builder: (context, snapshot) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create:
                  (context) =>
                      TodoBloc(TodoRepoImpl(datasource))..add(LoadTodoEvent()),
            ),
          ],
          child: RootScreen(),
        );
      },
    );
  }
}
