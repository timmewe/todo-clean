import 'package:todo_clean/core/error/failures.dart';
import 'package:todo_clean/core/usecases/use_case_interface.dart';

abstract class IRefreshTodosUseCaseDatasource {
  Future<Failure?> refreshTodos();
}

class RefreshTodosUsecase implements IUseCase<Failure?, NoParams> {
  final IRefreshTodosUseCaseDatasource datasource;

  RefreshTodosUsecase(this.datasource);

  @override
  Future<Failure?> call(NoParams params) {
    return datasource.refreshTodos();
  }
}
