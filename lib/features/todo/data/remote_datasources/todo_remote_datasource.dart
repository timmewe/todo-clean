import 'package:todo_clean/features/todo/data/remote_datasources/todo_raw.dart';

abstract class ITodoRemoteDatasource {
  Future<List<TodoRaw>> getTodos();
}
