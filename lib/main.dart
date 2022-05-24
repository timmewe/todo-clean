import 'package:flutter/material.dart';
import 'package:todo_clean/features/todo/presentation/pages/todos_page.dart';
import 'package:todo_clean/injection_container.dart' as injectionContainer;

import 'core/utils/local_storage_helper.dart';

Future<void> main() async {
  await LocalStorageHelper().initLocalStorage();
  await injectionContainer.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todos',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const TodosPage(),
    );
  }
}
