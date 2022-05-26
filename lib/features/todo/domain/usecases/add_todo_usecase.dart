import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_clean/core/error/failures.dart';
import 'package:todo_clean/core/usecases/use_case_interface.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/domain/repositories/todo_repository_interface.dart';

class AddTodoUsecase implements IUseCase<List<Todo>, Params> {
  final ITodoRepository repository;

  AddTodoUsecase(this.repository);

  @override
  Future<Either<List<Todo>, Failure>> call(Params params) async {
    return repository.addTodo(params.todo);
  }
}

class Params extends Equatable {
  final Todo todo;

  const Params({required this.todo});

  @override
  List<Object?> get props => [todo];
}
