import 'package:dartz/dartz.dart';
import 'package:todo_clean/core/error/failures.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/domain/usecases/get_todos_usecase.dart';
import 'package:todo_clean/features/todo/domain/usecases/refresh_todos_usecase.dart';
import 'package:todo_clean/features/todo/domain/usecases/save_todo_usecase.dart';

typedef EitherTodosOrFailure = Either<List<Todo>, Failure>;

abstract class ITodoRepository
    implements
        IGetTodosUseCaseDatasource,
        IRefreshTodosUseCaseDatasource,
        ISaveTodoUseCaseDatasource {
  @override
  Stream<List<Todo>> getTodos();

  @override
  Future<Failure?> refreshTodos();

  @override
  Future<void> saveTodo(Todo todo);

  Future<EitherTodosOrFailure> deleteTodo(int id);

  Future<EitherTodosOrFailure> markCompleted(int id);
}
