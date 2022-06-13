import 'package:todo_clean/features/todo/domain/entities/todo.dart';

abstract class ITodoLocalDatasource {
  Stream<List<Todo>> getTodos();

  Future<void> saveTodos(List<Todo> todos);

  Future<void> saveTodo(Todo todo);
}
