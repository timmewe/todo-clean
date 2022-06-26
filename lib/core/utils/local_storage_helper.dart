import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_clean/core/constants/box_keys.dart' as BoxKeys;
import 'package:todo_clean/features/todo/data/local_datasources/todo_db.dart';

class LocalStorageHelper {
  Future<void> initLocalStorage() async {
    await Hive.initFlutter();

    Hive.registerAdapter(TodoDbAdapter());

    await Future.wait([
      Hive.openBox<TodoDb>(BoxKeys.todoBoxKey),
    ]);
  }
}
