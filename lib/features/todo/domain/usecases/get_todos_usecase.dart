import 'package:dartz/dartz.dart';
import 'package:todo_clean/core/error/failures.dart';
import 'package:todo_clean/core/usecases/use_case_interface.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/domain/repositories/todo_repository_interface.dart';

class GetTodosUsecase implements IUseCase<List<Todo>, NoParams> {
  final ITodoRepository repository;

  GetTodosUsecase(this.repository);

  @override
  Future<Either<List<Todo>, Failure>> call(NoParams params) async {
    return repository.getTodos();
  }
}
