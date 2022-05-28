import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_clean/core/error/failures.dart';
import 'package:todo_clean/core/usecases/use_case_interface.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/domain/usecases/get_todos_usecase.dart';
import 'package:todo_clean/features/todo/domain/usecases/refresh_todos_usecase.dart';
import 'package:todo_clean/features/todo/presentation/pages/todos/bloc/todos_bloc.dart';

import 'todos_bloc_test.mocks.dart';

@GenerateMocks([GetTodosUsecase, RefreshTodosUsecase])
void main() {
  late TodosBloc bloc;
  late MockGetTodosUsecase mockGetTodosUsecase;
  late MockRefreshTodosUsecase mockRefreshTodosUsecase;

  setUp(() {
    mockGetTodosUsecase = MockGetTodosUsecase();
    mockRefreshTodosUsecase = MockRefreshTodosUsecase();
    bloc = TodosBloc(getTodos: mockGetTodosUsecase, refreshTodos: mockRefreshTodosUsecase);
  });

  test('Initial state should be have status .initial', () async {
    // assert
    expect(bloc.state, const TodosState());
  });

  group('TodosSubscriptionRequested', () {
    final tTodosList = [const Todo(id: 0, title: 'Test', completed: false)];

    test('should get data from the concrete usecase', () async {
      // arrange
      when(mockGetTodosUsecase.call(NoParams())).thenAnswer(
        (_) => Stream.value(tTodosList),
      );

      // act
      bloc.add(TodosSubscriptionRequested());
      await untilCalled(mockGetTodosUsecase(any));

      // assert
      verify(mockGetTodosUsecase(NoParams()));
    });

    test('should emit states with staus [.loading, .success] when data is gotten successfully', () async {
      // arrange
      when(mockGetTodosUsecase(NoParams())).thenAnswer((_) => Stream.value(tTodosList));

      // assert later
      final expected = [
        const TodosState(status: TodosStatus.loading),
        TodosState(status: TodosStatus.success, todos: tTodosList)
      ];
      unawaited(expectLater(bloc.stream, emitsInOrder(expected)));

      // act
      bloc.add(TodosSubscriptionRequested());
    });
  });

  group('RefreshTodos', () {
    test('should call the concrete usecase', () async {
      // arrange
      when(mockRefreshTodosUsecase.call(NoParams())).thenAnswer(
        (_) async => null,
      );

      // act
      bloc.add(RefreshTodos());
      await untilCalled(mockRefreshTodosUsecase(any));

      // assert
      verify(mockRefreshTodosUsecase(NoParams()));
    });

    test('should emit state with status .failure if an error occurs', () async {
      // arrange
      when(mockRefreshTodosUsecase.call(NoParams())).thenAnswer(
        (_) async => NoInternetConnectionFailure(),
      );

      // assert later
      final expected = [
        TodosState(message: NoInternetConnectionFailure().message),
      ];
      unawaited(expectLater(bloc.stream, emitsInOrder(expected)));

      // act
      bloc.add(RefreshTodos());
    });
  });
}
