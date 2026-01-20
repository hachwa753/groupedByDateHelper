import 'package:flutter/material.dart';
import 'package:groupedbydate/core/di/injection.dart';
import 'package:groupedbydate/domain/data/datasource.dart';
import 'package:groupedbydate/presentaion/wrapper/bloc_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: BlocWrapper());
  }
}
