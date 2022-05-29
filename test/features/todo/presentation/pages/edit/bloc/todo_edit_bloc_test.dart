import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/presentation/pages/edit/bloc/todo_edit_bloc.dart';

void main() {
  late TodoEditBloc bloc;
  setUp(() {
    bloc = TodoEditBloc();
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
}
