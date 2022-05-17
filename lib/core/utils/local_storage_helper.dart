import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_clean/core/constants/box_keys.dart' as BoxKeys;
import 'package:todo_clean/features/todo/data/tables/todo_table.dart';

class LocalStorageHelper {
  Future<void> initLocalStorage() async {
    await Hive.initFlutter();

    Hive.registerAdapter(TodoTableAdapter());

    await Future.wait([
      Hive.openBox<TodoTable>(BoxKeys.todoBoxKey),
    ]);
  }
}
