import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_clean/core/error/exceptions.dart';
import 'package:todo_clean/core/error/failures.dart';
import 'package:todo_clean/core/network/network_info.dart';
import 'package:todo_clean/features/todo/data/datasources/todo_local_datascource.dart';
import 'package:todo_clean/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:todo_clean/features/todo/data/models/todo_model.dart';
import 'package:todo_clean/features/todo/data/repositories/todo_repository.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';

import 'todo_repository_test.mocks.dart';

@GenerateMocks([ITodoRemoteDatasource, ITodoLocalDatasource, INetworkInfo])
void main() {
  late TodoRepository repository;
  late MockITodoRemoteDatasource mockRemoteDatasource;
  late MockITodoLocalDatasource mockLocalDatasource;
  late MockINetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDatasource = MockITodoRemoteDatasource();
    mockLocalDatasource = MockITodoLocalDatasource();
    mockNetworkInfo = MockINetworkInfo();
    repository = TodoRepository(
      remoteDatasource: mockRemoteDatasource,
      localDatasource: mockLocalDatasource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getTodos()', () {
    const tTodoModel = TodoModel(id: 0, title: "Test", completed: false);
    const tTodoList = [tTodoModel];

    test('should check if the device online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDatasource.getTodos()).thenAnswer((_) async => tTodoList);

      // act
      await repository.getTodos();

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return remote data when the call to remote datasource is successful', () async {
        // arrange
        when(mockRemoteDatasource.getTodos()).thenAnswer((_) async => tTodoList);

        // act
        final result = await repository.getTodos();

        // assert
        verify(mockRemoteDatasource.getTodos());
        expect(result, const Left<List<Todo>, Failure>(tTodoList));
      });

      test('should save the data locally when the call to remote datasource is successful',
          () async {
        // arrange
        when(mockRemoteDatasource.getTodos()).thenAnswer((_) async => tTodoList);

        // act
        await repository.getTodos();

        // assert
        verify(mockRemoteDatasource.getTodos());
        verify(mockLocalDatasource.saveTodos(tTodoList));
      });

      test('should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDatasource.getTodos()).thenThrow(ServerException());

        // act
        final result = await repository.getTodos();

        // assert
        verify(mockRemoteDatasource.getTodos());
        verifyZeroInteractions(mockLocalDatasource);
        expect(result, Right<List<Todo>, Failure>(ServerFailure()));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return last locally saved data when data is present', () async {
        // arrange
        when(mockLocalDatasource.getTodos()).thenAnswer((_) async => tTodoList);

        // act
        final result = await repository.getTodos();

        // assert
        verifyZeroInteractions(mockRemoteDatasource);
        verify(mockLocalDatasource.getTodos());
        expect(result, const Left<List<Todo>, Failure>(tTodoList));
      });

      test('should return database failure when data is not present', () async {
        // arrange
        when(mockLocalDatasource.getTodos()).thenThrow(DatabaseException());

        // act
        final result = await repository.getTodos();

        // assert
        verifyZeroInteractions(mockRemoteDatasource);
        verify(mockLocalDatasource.getTodos());
        expect(result, Right<List<Todo>, Failure>(DatabaseFailure()));
      });
    });
  });

  group('addTodo', () {
    const tTodoModel = TodoModel(id: 0, title: "Test", completed: false);
    const tTodoList = [tTodoModel];

    test('should check if the device online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDatasource.addTodo(any)).thenAnswer(
        (_) async => tTodoModel,
      );
      when(mockLocalDatasource.getTodos()).thenAnswer((_) async => tTodoList);

      // act
      await repository.addTodo(tTodoModel);

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should save the data locally when the call to remote datasource is successful',
          () async {
        // arrange
        when(mockRemoteDatasource.addTodo(any)).thenAnswer((_) async => tTodoModel);
        when(mockLocalDatasource.getTodos()).thenAnswer((_) async => tTodoList);

        // act
        await repository.addTodo(tTodoModel);

        // assert
        verify(mockRemoteDatasource.addTodo(any));
        verify(mockLocalDatasource.addTodo(any));
      });

      test(
          'should return remote data + local data when the call to remote datasource is successful',
          () async {
        // arrange
        when(mockRemoteDatasource.addTodo(any)).thenAnswer((_) async => tTodoModel);
        when(mockLocalDatasource.getTodos()).thenAnswer((_) async => tTodoList);

        // act
        final result = await repository.addTodo(tTodoModel);

        // assert
        verify(mockRemoteDatasource.addTodo(tTodoModel));
        verify(mockLocalDatasource.getTodos());
        expect(result, const Left<List<Todo>, Failure>(tTodoList));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return saved todos when data is present', () async {
        // arrange
        when(mockLocalDatasource.getTodos()).thenAnswer((_) async => tTodoList);

        // act
        final result = await repository.addTodo(tTodoModel);

        // assert
        verifyZeroInteractions(mockRemoteDatasource);
        verify(mockLocalDatasource.getTodos());
        expect(result, Right<List<Todo>, Failure>(AddTodoFailure(tTodoList)));
      });

      test('should return database failure when data is not present', () async {
        // arrange
        when(mockLocalDatasource.getTodos()).thenThrow(DatabaseException());

        // act
        final result = await repository.addTodo(tTodoModel);

        // assert
        verifyZeroInteractions(mockRemoteDatasource);
        verify(mockLocalDatasource.getTodos());
        expect(result, Right<List<Todo>, Failure>(DatabaseFailure()));
      });
    });
  });
}
