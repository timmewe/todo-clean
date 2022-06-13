// Mocks generated by Mockito 5.1.0 from annotations
// in todo_clean/test/features/todo/presentation/pages/edit/bloc/todo_edit_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:todo_clean/core/error/failures.dart' as _i5;
import 'package:todo_clean/features/todo/domain/repositories/todo_repository_interface.dart' as _i2;
import 'package:todo_clean/features/todo/domain/usecases/save_todo_usecase.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeITodoRepository_0 extends _i1.Fake implements _i2.ITodoRepository {}

/// A class which mocks [SaveTodoUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveTodoUsecase extends _i1.Mock implements _i3.SaveTodoUsecase {
  MockSaveTodoUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ITodoRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository), returnValue: _FakeITodoRepository_0())
          as _i2.ITodoRepository);
  @override
  _i4.Future<_i5.Failure?> call(_i3.Params? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
          returnValue: Future<_i5.Failure?>.value()) as _i4.Future<_i5.Failure?>);
}
