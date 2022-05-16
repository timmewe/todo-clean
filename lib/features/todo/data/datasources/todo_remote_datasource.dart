import 'package:todo_clean/features/todo/domain/entities/todo.dart';

abstract class ITodoRemoteDatasource {
  Future<List<Todo>> getTodos();
  Future<Todo> addTodo(Todo todo);
  Future<bool> deleteTodo(int id);
  Future<Todo> markCompleted(int id);
}