import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_clean/core/error/failures.dart';
import 'package:todo_clean/core/usecases/use_case_interface.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/domain/usecases/get_todos_usecase.dart';
import 'package:todo_clean/features/todo/presentation/pages/todos/bloc/todos_bloc.dart';

import 'todos_bloc_test.mocks.dart';

@GenerateMocks([GetTodosUsecase])
void main() {
  late TodosBloc bloc;
  late MockGetTodosUsecase mockGetTodosUsecase;

  setUp(() {
    mockGetTodosUsecase = MockGetTodosUsecase();
    bloc = TodosBloc(getTodos: mockGetTodosUsecase);
  });

  test('Initial state should be [TodosInitial]', () async {
    // assert
    expect(bloc.state, TodosInitial());
  });

  group('GetTodos', () {
    final tTodosList = [const Todo(id: 0, title: 'Test', completed: false)];

    test('should get data from the concrete usecase', () async {
      // arrange
      when(mockGetTodosUsecase.call(NoParams())).thenAnswer(
        (_) async => Left(tTodosList),
      );

      // act
      bloc.add(GetTodos());
      await untilCalled(mockGetTodosUsecase(any));

      // assert
      verify(mockGetTodosUsecase(NoParams()));
    });

    test('should emit [TodosLoading, TodosLoaded] when data is gotten successfully', () async {
      // arrange
      when(mockGetTodosUsecase(NoParams())).thenAnswer((_) async => Left(tTodosList));

      // assert later
      final expected = [TodosLoading(), TodosLoaded(todos: tTodosList)];
      unawaited(expectLater(bloc.stream, emitsInOrder(expected)));

      // act
      bloc.add(GetTodos());
    });

    test('should emit [TodosLoading, TodosLoadError] when getting data fails', () async {
      // arrange
      when(mockGetTodosUsecase(NoParams())).thenAnswer((_) async => Right(ServerFailure()));

      // assert later
      final expected = [TodosLoading(), const TodosLoadError(errorMessage: serverFailureMessage)];
      unawaited(expectLater(bloc.stream, emitsInOrder(expected)));

      // act
      bloc.add(GetTodos());
    });

    test(
        'should emit [TodosLoading, TodosLoadError] with a proper message for the error when getting data fails',
        () async {
      // arrange
      when(mockGetTodosUsecase(NoParams())).thenAnswer((_) async => Right(DatabaseFailure()));

      // assert later
      final expected = [TodosLoading(), const TodosLoadError(errorMessage: serverFailureMessage)];
      unawaited(expectLater(bloc.stream, emitsInOrder(expected)));

      // act
      bloc.add(GetTodos());
    });
  });
}
