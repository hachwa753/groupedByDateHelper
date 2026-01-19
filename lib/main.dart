import 'package:flutter/material.dart';
import 'package:groupedbydate/domain/data/datasource.dart';
import 'package:groupedbydate/presentaion/wrapper/bloc_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final datasource = Datasource();
  await datasource.loadTodos();

  runApp(MyApp(datasource: datasource));
}

class MyApp extends StatelessWidget {
  final Datasource datasource;
  const MyApp({super.key, required this.datasource});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocWrapper(datasource: datasource),
    );
  }
}
