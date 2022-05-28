import 'package:todo_clean/core/usecases/use_case_interface.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/domain/repositories/todo_repository_interface.dart';

class GetTodosUsecase implements IUseCase<Stream<List<Todo>>, NoParams> {
  final ITodoRepository repository;

  GetTodosUsecase(this.repository);

  @override
  Stream<List<Todo>> call(NoParams params) {
    return repository.getTodos();
  }
}
