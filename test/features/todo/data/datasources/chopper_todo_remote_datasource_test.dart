import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_clean/core/api/todo_api.dart';
import 'package:todo_clean/core/error/exceptions.dart';
import 'package:todo_clean/features/todo/data/datasources/chopper_todo_remote_datasource.dart';
import 'package:todo_clean/features/todo/data/models/todo_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'chopper_todo_remote_datasource_test.mocks.dart';

@GenerateMocks([TodoApi, http.Client])
void main() {
  late ChopperTodoRemoteDatasource datasource;
  late TodoApi mockTodoApi;
  late MockClient mockHttpClient;
  late ChopperClient chopperClient;

  ChopperClient mockChopperClient(http.Client client) => ChopperClient(
        client: client,
        baseUrl: 'https://jsonplaceholder.typicode.com/',
      );

  http.StreamedResponse getErrorResponse() {
    return http.StreamedResponse(
      Stream.value("Something went wrong".codeUnits),
      404,
    );
  }

  setUp(() {
    mockHttpClient = MockClient();
    chopperClient = mockChopperClient(mockHttpClient);
    mockTodoApi = TodoApi.create(chopperClient);
    datasource = ChopperTodoRemoteDatasource(api: mockTodoApi);
  });

  group('getTodos()', () {
    final tTodoListModel = [
      TodoModel.fromJson(
        jsonDecode(
          fixture('todo.json'),
        ) as Map<String, dynamic>,
      )
    ];

    test('should return todos when the response code is 200', () async {
      // arrange
      final streamedResponse =
          http.StreamedResponse(Stream.value(fixture("todos.json").codeUnits), 200);
      when(mockHttpClient.send(any)).thenAnswer((_) async => streamedResponse);

      // act
      final result = await datasource.getTodos();

      // assert
      expect(result, tTodoListModel);
    });

    test('should throw a ServerException when the server response is a 404 or other', () async {
      // arrange
      final streamedResponse = getErrorResponse();
      when(mockHttpClient.send(any)).thenAnswer((_) async => streamedResponse);

      // act
      final call = datasource.getTodos;

      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });
}
