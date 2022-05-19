import 'package:todo_clean/features/todo/data/models/todo_model.dart';

abstract class ITodoRemoteDatasource {
  Future<List<TodoModel>> getTodos();
  Future<TodoModel> addTodo(TodoModel todo);
  Future<bool> deleteTodo(int id);
  Future<TodoModel> markCompleted(int id);
}
