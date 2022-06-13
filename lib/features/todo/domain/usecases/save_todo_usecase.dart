import 'package:equatable/equatable.dart';
import 'package:todo_clean/core/usecases/use_case_interface.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/domain/repositories/todo_repository_interface.dart';

class SaveTodoUsecase implements IUseCase<void, Params> {
  final ITodoRepository repository;

  SaveTodoUsecase(this.repository);

  @override
  Future<void> call(Params params) {
    return repository.saveTodo(params.todo);
  }
}

class Params extends Equatable {
  final Todo todo;

  const Params({required this.todo});

  @override
  List<Object?> get props => [todo];
}
