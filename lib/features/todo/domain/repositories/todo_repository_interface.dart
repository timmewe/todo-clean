import 'package:dartz/dartz.dart';
import 'package:todo_clean/core/error/failures.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';

typedef EitherTodosOrFailure = Either<List<Todo>, Failure>;

abstract class ITodoRepository {
  Stream<List<Todo>> getTodos();
  Future<Failure?> refreshTodos();
  Future<void> saveTodo(Todo todo);
  Future<EitherTodosOrFailure> deleteTodo(int id);
  Future<EitherTodosOrFailure> markCompleted(int id);
}
