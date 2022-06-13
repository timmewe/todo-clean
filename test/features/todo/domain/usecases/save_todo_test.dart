import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/domain/usecases/save_todo_usecase.dart';

import 'get_todos_test.mocks.dart';

void main() {
  late final SaveTodoUsecase usecase;
  late final MockITodoRepository repository;

  setUp(() {
    repository = MockITodoRepository();
    usecase = SaveTodoUsecase(repository);
  });

  const todo = Todo(id: 0, title: "Test", completed: false);

  test("should get null when todo could be saved", () async {
    // arrange
    when(repository.saveTodo(todo)).thenAnswer((_) async {});

    // act
    final result = await usecase(const Params(todo: todo));

    // assert
    verify(repository.saveTodo(any));
    verifyNoMoreInteractions(repository);
  });
}
