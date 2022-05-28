import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_clean/core/usecases/use_case_interface.dart';
import 'package:todo_clean/features/todo/domain/repositories/todo_repository_interface.dart';
import 'package:todo_clean/features/todo/domain/usecases/refresh_todos_usecase.dart';

import 'get_todos_test.mocks.dart';

@GenerateMocks([ITodoRepository])
void main() {
  late final RefreshTodosUsecase usecase;
  late final MockITodoRepository repository;

  setUp(() {
    repository = MockITodoRepository();
    usecase = RefreshTodosUsecase(repository);
  });

  test("should return null from the repository", () async {
    // arrange
    when(repository.refreshTodos()).thenAnswer((_) async => null);

    // act
    final result = await usecase(NoParams());

    // assert
    verify(repository.refreshTodos());
    verifyNoMoreInteractions(repository);
    expect(result, isNull);
  });
}
