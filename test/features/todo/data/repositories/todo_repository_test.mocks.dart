// Mocks generated by Mockito 5.1.0 from annotations
// in todo_clean/test/features/todo/data/repositories/todo_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:todo_clean/core/network/network_info.dart' as _i7;
import 'package:todo_clean/features/todo/data/datasources/todo_local_datascource.dart' as _i5;
import 'package:todo_clean/features/todo/data/datasources/todo_remote_datasource.dart' as _i3;
import 'package:todo_clean/features/todo/data/models/todo_model.dart' as _i2;
import 'package:todo_clean/features/todo/domain/entities/todo.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeTodoModel_0 extends _i1.Fake implements _i2.TodoModel {}

/// A class which mocks [ITodoRemoteDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockITodoRemoteDatasource extends _i1.Mock implements _i3.ITodoRemoteDatasource {
  MockITodoRemoteDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i2.TodoModel>> getTodos() =>
      (super.noSuchMethod(Invocation.method(#getTodos, []),
              returnValue: Future<List<_i2.TodoModel>>.value(<_i2.TodoModel>[]))
          as _i4.Future<List<_i2.TodoModel>>);
  @override
  _i4.Future<_i2.TodoModel> addTodo(_i2.TodoModel? todo) => (super.noSuchMethod(
      Invocation.method(#addTodo, [todo]),
      returnValue: Future<_i2.TodoModel>.value(_FakeTodoModel_0())) as _i4.Future<_i2.TodoModel>);
  @override
  _i4.Future<bool> deleteTodo(int? id) => (super.noSuchMethod(Invocation.method(#deleteTodo, [id]),
      returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
  @override
  _i4.Future<_i2.TodoModel> markCompleted(int? id) => (super.noSuchMethod(
      Invocation.method(#markCompleted, [id]),
      returnValue: Future<_i2.TodoModel>.value(_FakeTodoModel_0())) as _i4.Future<_i2.TodoModel>);
}

/// A class which mocks [ITodoLocalDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockITodoLocalDatasource extends _i1.Mock implements _i5.ITodoLocalDatasource {
  MockITodoLocalDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Stream<List<_i6.Todo>> getTodos() => (super.noSuchMethod(Invocation.method(#getTodos, []),
      returnValue: Stream<List<_i6.Todo>>.empty()) as _i4.Stream<List<_i6.Todo>>);
  @override
  _i4.Future<void> saveTodos(List<_i6.Todo>? todos) =>
      (super.noSuchMethod(Invocation.method(#saveTodos, [todos]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> addTodo(_i6.Todo? todo) =>
      (super.noSuchMethod(Invocation.method(#addTodo, [todo]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
}

/// A class which mocks [INetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockINetworkInfo extends _i1.Mock implements _i7.INetworkInfo {
  MockINetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected), returnValue: Future<bool>.value(false))
          as _i4.Future<bool>);
}
