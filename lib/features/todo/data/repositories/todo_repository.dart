import 'package:dartz/dartz.dart';
import 'package:todo_clean/core/error/failures.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/domain/repositories/todo_repository_interface.dart';

class TodoRepository implements ITodoRepository {
  @override
  Future<Either<Todo, Failure>> addTodo(Todo todo) {
    // TODO: implement addTodo
    throw UnimplementedError();
  }

  @override
  Future<Failure> deleteTodo(int id) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  Future<Either<List<Todo>, Failure>> getTodos() {
    // TODO: implement getTodos
    throw UnimplementedError();
  }

  @override
  Future<Either<Todo, Failure>> markCompleted(int id) {
    // TODO: implement markCompleted
    throw UnimplementedError();
  }
  
}