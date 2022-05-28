import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/domain/usecases/add_todo_usecase.dart';

import 'get_todos_test.mocks.dart';

void main() {
  late final AddTodoUsecase usecase;
  late final MockITodoRepository repository;

  setUp(() {
    repository = MockITodoRepository();
    usecase = AddTodoUsecase(repository);
  });

  const todo = Todo(id: 0, title: "Test", completed: false);

  test("should get null when todo could be added", () async {
    // arrange
    when(repository.addTodo(todo)).thenAnswer((_) async => null);

    // act
    final result = await usecase(const Params(todo: todo));

    // assert
    verify(repository.addTodo(any));
    verifyNoMoreInteractions(repository);
    expect(result, isNull);
  });
}
