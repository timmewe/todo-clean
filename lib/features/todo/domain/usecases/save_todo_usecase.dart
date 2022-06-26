import 'package:equatable/equatable.dart';
import 'package:todo_clean/core/usecases/use_case_interface.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';

abstract class ISaveTodoUseCaseDatasource {
  Future<void> saveTodo(Todo todo);
}

class SaveTodoUsecase implements IUseCase<void, Params> {
  final ISaveTodoUseCaseDatasource datasource;

  SaveTodoUsecase(this.datasource);

  @override
  Future<void> call(Params params) {
    return datasource.saveTodo(params.todo);
  }
}

class Params extends Equatable {
  final Todo todo;

  const Params({required this.todo});

  @override
  List<Object?> get props => [todo];
}
