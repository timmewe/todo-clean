// Mocks generated by Mockito 5.1.0 from annotations
// in todo_clean/test/features/todo/data/datasources/chopper_todo_remote_datasource_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;
import 'dart:convert' as _i6;
import 'dart:typed_data' as _i7;

import 'package:chopper/chopper.dart' as _i2;
import 'package:http/http.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:todo_clean/core/api/todo_api.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeChopperClient_0 extends _i1.Fake implements _i2.ChopperClient {}

class _FakeType_1 extends _i1.Fake implements Type {}

class _FakeResponse_2<BodyType> extends _i1.Fake implements _i2.Response<BodyType> {}

class _FakeResponse_3 extends _i1.Fake implements _i3.Response {}

class _FakeStreamedResponse_4 extends _i1.Fake implements _i3.StreamedResponse {}

/// A class which mocks [TodoApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockTodoApi extends _i1.Mock implements _i4.TodoApi {
  MockTodoApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ChopperClient get client =>
      (super.noSuchMethod(Invocation.getter(#client), returnValue: _FakeChopperClient_0())
          as _i2.ChopperClient);
  @override
  set client(_i2.ChopperClient? _client) =>
      super.noSuchMethod(Invocation.setter(#client, _client), returnValueForMissingStub: null);
  @override
  Type get definitionType =>
      (super.noSuchMethod(Invocation.getter(#definitionType), returnValue: _FakeType_1()) as Type);
  @override
  _i5.Future<_i2.Response<dynamic>> getTodos() =>
      (super.noSuchMethod(Invocation.method(#getTodos, []),
              returnValue: Future<_i2.Response<dynamic>>.value(_FakeResponse_2<dynamic>()))
          as _i5.Future<_i2.Response<dynamic>>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockClient extends _i1.Mock implements _i3.Client {
  MockClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i3.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
          returnValue: Future<_i3.Response>.value(_FakeResponse_3())) as _i5.Future<_i3.Response>);
  @override
  _i5.Future<_i3.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
          returnValue: Future<_i3.Response>.value(_FakeResponse_3())) as _i5.Future<_i3.Response>);
  @override
  _i5.Future<_i3.Response> post(Uri? url,
          {Map<String, String>? headers, Object? body, _i6.Encoding? encoding}) =>
      (super.noSuchMethod(
          Invocation.method(#post, [url], {#headers: headers, #body: body, #encoding: encoding}),
          returnValue: Future<_i3.Response>.value(_FakeResponse_3())) as _i5.Future<_i3.Response>);
  @override
  _i5.Future<_i3.Response> put(Uri? url,
          {Map<String, String>? headers, Object? body, _i6.Encoding? encoding}) =>
      (super.noSuchMethod(
          Invocation.method(#put, [url], {#headers: headers, #body: body, #encoding: encoding}),
          returnValue: Future<_i3.Response>.value(_FakeResponse_3())) as _i5.Future<_i3.Response>);
  @override
  _i5.Future<_i3.Response> patch(Uri? url,
          {Map<String, String>? headers, Object? body, _i6.Encoding? encoding}) =>
      (super.noSuchMethod(
          Invocation.method(#patch, [url], {#headers: headers, #body: body, #encoding: encoding}),
          returnValue: Future<_i3.Response>.value(_FakeResponse_3())) as _i5.Future<_i3.Response>);
  @override
  _i5.Future<_i3.Response> delete(Uri? url,
          {Map<String, String>? headers, Object? body, _i6.Encoding? encoding}) =>
      (super.noSuchMethod(
          Invocation.method(#delete, [url], {#headers: headers, #body: body, #encoding: encoding}),
          returnValue: Future<_i3.Response>.value(_FakeResponse_3())) as _i5.Future<_i3.Response>);
  @override
  _i5.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i5.Future<String>);
  @override
  _i5.Future<_i7.Uint8List> readBytes(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#readBytes, [url], {#headers: headers}),
          returnValue: Future<_i7.Uint8List>.value(_i7.Uint8List(0))) as _i5.Future<_i7.Uint8List>);
  @override
  _i5.Future<_i3.StreamedResponse> send(_i3.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue: Future<_i3.StreamedResponse>.value(_FakeStreamedResponse_4()))
          as _i5.Future<_i3.StreamedResponse>);
  @override
  void close() =>
      super.noSuchMethod(Invocation.method(#close, []), returnValueForMissingStub: null);
}