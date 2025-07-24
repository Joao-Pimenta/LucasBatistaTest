import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'lucas_batista_test_exports.dart';

void main() {
  final getIt = GetIt.instance;
  AppBinds.call(getIt);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ChartsPage(),
    );
  }
}
