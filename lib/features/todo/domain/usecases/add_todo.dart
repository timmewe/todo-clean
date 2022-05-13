import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_clean/core/error/failures.dart';
import 'package:todo_clean/core/usecases/use_case_interface.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/domain/repositories/todo_repository.dart';

class AddTodo implements IUseCase<Todo, Params> {
  final TodoRepository repository;

  AddTodo(this.repository);

  @override
  Future<Either<Todo, Failure>> call(Params params) async {
    return repository.addTodo(params.todo);
  }
}

class Params extends Equatable {
  final Todo todo;

  const Params({required this.todo});

  @override
  List<Object?> get props => [todo];
}
