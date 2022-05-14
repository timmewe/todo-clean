import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_clean/core/error/failures.dart';
import 'package:todo_clean/core/usecases/use_case_interface.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/domain/repositories/todo_repository_interface.dart';
import 'package:todo_clean/features/todo/domain/usecases/get_todos.dart';

import 'get_todos_test.mocks.dart';

@GenerateMocks([ITodoRepository])
void main() {
  late final GetTodos usecase;
  late final MockTodoRepository repository;

  setUp(() {
    repository = MockTodoRepository();
    usecase = GetTodos(repository);
  });

  const todos = [Todo(id: 0, title: "Test", completed: false)];

  test("should get todos from the repository", () async {
    // arrange
    when(repository.getTodos()).thenAnswer((_) async => const Left(todos));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, const Left<List<Todo>, Failure>(todos));
    verify(repository.getTodos());
    verifyNoMoreInteractions(repository);
  });
}
