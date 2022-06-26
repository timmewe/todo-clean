import 'package:todo_clean/features/todo/data/local_datasources/todo_db.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';

abstract class ITodoLocalDatasource {
  Stream<List<TodoDb>> getTodos();

  Future<void> saveTodos(List<Todo> todos);

  Future<void> saveTodo(Todo todo);
}
