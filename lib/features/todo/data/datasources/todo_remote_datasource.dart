import 'package:todo_clean/features/todo/data/models/todo_model.dart';

abstract class ITodoRemoteDatasource {
  Future<List<TodoModel>> getTodos();
}
