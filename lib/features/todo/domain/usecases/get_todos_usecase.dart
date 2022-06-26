import 'package:todo_clean/core/usecases/use_case_interface.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';

class GetTodosUsecase implements IUseCase<Stream<List<Todo>>, NoParams> {
  final IGetTodosUseCaseDatasource datasource;

  GetTodosUsecase(this.datasource);

  @override
  Stream<List<Todo>> call(NoParams params) {
    return datasource.getTodos();
  }
}

abstract class IGetTodosUseCaseDatasource {
  Stream<List<Todo>> getTodos();
}
