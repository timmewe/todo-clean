import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_clean/core/error/failures.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/domain/usecases/add_todo.dart';

import 'get_todos_test.mocks.dart';

void main() {
  late final AddTodo usecase;
  late final MockTodoRepository repository;

  setUp(() {
    repository = MockTodoRepository();
    usecase = AddTodo(repository);
  });

  const todo = Todo(id: 0, title: "Test", completed: false);

  test("should get todo from the repository", () async {
    // arrange
    when(repository.addTodo(todo)).thenAnswer((_) async => const Left(todo));

    // act
    final result = await usecase(const Params(todo: todo));

    // assert
    expect(result, const Left<Todo, Failure>(todo));
    verify(repository.addTodo(any));
    verifyNoMoreInteractions(repository);
  });
}
