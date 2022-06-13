import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/domain/usecases/save_todo_usecase.dart';
import 'package:todo_clean/features/todo/presentation/pages/edit/bloc/todo_edit_bloc.dart';

import 'todo_edit_bloc_test.mocks.dart';

@GenerateMocks([SaveTodoUsecase])
void main() {
  late TodoEditBloc bloc;
  late MockSaveTodoUsecase mockSaveTodoUsecase;

  setUp(() {
    mockSaveTodoUsecase = MockSaveTodoUsecase();
    bloc = TodoEditBloc(saveTodo: mockSaveTodoUsecase);
  });

  test('Initial state should be [TodoEditInitial]', () async {
    // assert
    expect(bloc.state, TodoEditInitial());
  });

  group('Create new todo', () {
    test('should emit [TodoEditCreateNew] when passed in todo is null', () async {
      // arrange

      // assert later
      unawaited(expectLater(bloc.stream, emitsInOrder([TodoEditCreateNew()])));

      // act
      bloc.add(const TodoEditSetup());
    });
  });

  group('Edit todo', () {
    const tTodo = Todo(id: 0, title: 'Test', completed: false);
    test('should emit [TodoEditExisting] when passed in todo is not null', () async {
      // arrange

      // assert later
      unawaited(expectLater(bloc.stream, emitsInOrder([TodoEditExisting(todo: tTodo)])));

      // act
      bloc.add(const TodoEditSetup(todo: tTodo));
    });
  });

  group('Save todo', () {
    const tTodo = Todo(id: 0, title: 'Test', completed: false);
    test('should call the concrete usecase', () async {
      // arrange
      when(mockSaveTodoUsecase.call(any)).thenAnswer((_) async => null);

      // act
      bloc.add(const TodoEditSave(todo: tTodo));
      await untilCalled(mockSaveTodoUsecase.call(any));

      // assert
      verify(mockSaveTodoUsecase.call(const Params(todo: tTodo)));
    });

    test(
        'should emit states [TodoEditLoading, TodoEditSaveSuccess] when the data got saved successfully',
        () async {
      // arrange
      when(mockSaveTodoUsecase.call(any)).thenAnswer((_) async => null);

      // assert later
      final expected = [TodoEditLoading(todo: tTodo), TodoEditSaveSuccess()];
      unawaited(expectLater(bloc.stream, emitsInOrder(expected)));

      // act
      bloc.add(const TodoEditSave(todo: tTodo));
    });
  });
}
