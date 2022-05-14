import 'package:dartz/dartz.dart';
import 'package:todo_clean/core/error/failures.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';

abstract class ITodoRepository {
  Future<Either<List<Todo>, Failure>> getTodos();
  Future<Either<Todo, Failure>> addTodo(Todo todo);
  Future<Failure> deleteTodo(int id);
  Future<Either<Todo, Failure>> markCompleted(int id);
}
