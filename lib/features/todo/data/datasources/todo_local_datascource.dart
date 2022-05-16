import 'package:todo_clean/features/todo/domain/entities/todo.dart';

abstract class ITodoLocalDatasource {
  Future<List<Todo>> getTodos();
  Future<void> saveTodos(List<Todo> todos);
  Future<void> saveTodo(Todo todo);
  Future<void> deleteTodo(Todo todo);
  Future<void> markCompleted(int id);
}
