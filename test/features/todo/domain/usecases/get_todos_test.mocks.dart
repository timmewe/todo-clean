// Mocks generated by Mockito 5.1.0 from annotations
// in todo_clean/test/features/todo/domain/usecases/get_todos_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:todo_clean/core/error/failures.dart' as _i6;
import 'package:todo_clean/features/todo/domain/entities/todo.dart' as _i5;
import 'package:todo_clean/features/todo/domain/repositories/todo_repository_interface.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [ITodoRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockITodoRepository extends _i1.Mock implements _i3.ITodoRepository {
  MockITodoRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<List<_i5.Todo>, _i6.Failure>> getTodos() =>
      (super.noSuchMethod(Invocation.method(#getTodos, []),
          returnValue: Future<_i2.Either<List<_i5.Todo>, _i6.Failure>>.value(
              _FakeEither_0<List<_i5.Todo>, _i6.Failure>())) as _i4
          .Future<_i2.Either<List<_i5.Todo>, _i6.Failure>>);
  @override
  _i4.Future<_i2.Either<List<_i5.Todo>, _i6.Failure>> addTodo(_i5.Todo? todo) =>
      (super.noSuchMethod(Invocation.method(#addTodo, [todo]),
          returnValue: Future<_i2.Either<List<_i5.Todo>, _i6.Failure>>.value(
              _FakeEither_0<List<_i5.Todo>, _i6.Failure>())) as _i4
          .Future<_i2.Either<List<_i5.Todo>, _i6.Failure>>);
  @override
  _i4.Future<_i2.Either<List<_i5.Todo>, _i6.Failure>> deleteTodo(int? id) =>
      (super.noSuchMethod(Invocation.method(#deleteTodo, [id]),
          returnValue: Future<_i2.Either<List<_i5.Todo>, _i6.Failure>>.value(
              _FakeEither_0<List<_i5.Todo>, _i6.Failure>())) as _i4
          .Future<_i2.Either<List<_i5.Todo>, _i6.Failure>>);
  @override
  _i4.Future<_i2.Either<List<_i5.Todo>, _i6.Failure>> markCompleted(int? id) =>
      (super.noSuchMethod(Invocation.method(#markCompleted, [id]),
          returnValue: Future<_i2.Either<List<_i5.Todo>, _i6.Failure>>.value(
              _FakeEither_0<List<_i5.Todo>, _i6.Failure>())) as _i4
          .Future<_i2.Either<List<_i5.Todo>, _i6.Failure>>);
}
