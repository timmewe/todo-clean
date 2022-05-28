import 'package:todo_clean/core/error/failures.dart';
import 'package:todo_clean/core/usecases/use_case_interface.dart';
import 'package:todo_clean/features/todo/domain/repositories/todo_repository_interface.dart';

class RefreshTodosUsecase implements IUseCase<Failure?, NoParams> {
  final ITodoRepository repository;

  RefreshTodosUsecase(this.repository);

  @override
  Future<Failure?> call(NoParams params) {
    return repository.refreshTodos();
  }
}
