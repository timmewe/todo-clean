import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:todo_clean/core/constants/routes.dart' as routes;
import 'package:todo_clean/injection_container.dart' as injectionContainer;
import 'package:todo_clean/router.dart' as router;

import 'core/utils/local_storage_helper.dart';

Future<void> main() async {
  await LocalStorageHelper().initLocalStorage();
  await injectionContainer.init();
  _setupLogging();
  runApp(const MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
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
      onGenerateRoute: router.generateRoute,
      initialRoute: routes.todosPageRoute,
    );
  }
}
