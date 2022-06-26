import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_clean/core/error/exceptions.dart';
import 'package:todo_clean/core/error/failures.dart';
import 'package:todo_clean/core/network/network_info.dart';
import 'package:todo_clean/features/todo/data/local_datasources/todo_db.dart';
import 'package:todo_clean/features/todo/data/local_datasources/todo_local_datascource.dart';
import 'package:todo_clean/features/todo/data/remote_datasources/todo_raw.dart';
import 'package:todo_clean/features/todo/data/remote_datasources/todo_remote_datasource.dart';
import 'package:todo_clean/features/todo/data/repositories/todo_repository.dart';

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
    const tTodoTable = TodoDb(id: 0, title: "Test", completed: false);
    final tTodo = tTodoTable.mapToEntity();
    const tTodoList = [tTodoTable];

    test('should return a stream of the saved todos', () async {
      // arrange
      when(mockLocalDatasource.getTodos()).thenAnswer((_) => Stream.value(tTodoList));

      // act
      final result = repository.getTodos();

      // assert
      verifyZeroInteractions(mockRemoteDatasource);
      verify(mockLocalDatasource.getTodos());
      expect(
        result,
        emitsInOrder([
          [tTodo],
          emitsDone
        ]),
      );
    });
  });

  group('refreshTodos', () {
    const tTodoModel = TodoRaw(id: 0, title: "Test", completed: false);
    const tTodoList = [tTodoModel];

    test('should check if the device online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDatasource.getTodos()).thenAnswer((_) async => tTodoList);

      // act
      await repository.refreshTodos();

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should save remote data to local storage when the call to remote datasource is successful',
          () async {
        // arrange
        when(mockRemoteDatasource.getTodos()).thenAnswer((_) async => tTodoList);

        // act
        final result = await repository.refreshTodos();

        // assert
        verify(mockRemoteDatasource.getTodos());
        verify(mockLocalDatasource.saveTodos(tTodoList));
        expect(result, isNull);
      });

      test('should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDatasource.getTodos()).thenThrow(ServerException());

        // act
        final result = await repository.refreshTodos();

        // assert
        verify(mockRemoteDatasource.getTodos());
        verifyZeroInteractions(mockLocalDatasource);
        expect(result, ServerFailure());
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return NoInternetConnectionFailure', () async {
        // act
        final result = await repository.refreshTodos();

        // assert
        verifyZeroInteractions(mockRemoteDatasource);
        verifyZeroInteractions(mockLocalDatasource);
        expect(result, NoInternetConnectionFailure());
      });
    });
  });

  group('addTodo', () {
    const tTodoModel = TodoRaw(id: 0, title: "Test", completed: false);
    const tTodoList = [tTodoModel];

    test('should save the data locally', () async {
      // arrange
      when(mockLocalDatasource.saveTodo(any)).thenAnswer((_) async => tTodoModel);

      // act
      await repository.saveTodo(tTodoModel);

      // assert
      verify(mockLocalDatasource.saveTodo(tTodoModel));
    });

    // test('should check if the device online', () async {
    //   // arrange
    //   when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    //   when(mockRemoteDatasource.saveTodo(any)).thenAnswer(
    //     (_) async => tTodoModel,
    //   );
    //   when(mockLocalDatasource.getTodos()).thenAnswer((_) => Stream.value(tTodoList));
    //
    //   // act
    //   await repository.saveTodo(tTodoModel);
    //
    //   // assert
    //   verify(mockNetworkInfo.isConnected);
    // });
    //
    // group('device is online', () {
    //   setUp(() {
    //     when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    //   });
    //
    //   test('should save the data locally when the call to remote datasource is successful',
    //       () async {
    //     // arrange
    //     when(mockRemoteDatasource.saveTodo(any)).thenAnswer((_) async => tTodoModel);
    //
    //     // act
    //     await repository.saveTodo(tTodoModel);
    //
    //     // assert
    //     verify(mockRemoteDatasource.saveTodo(any));
    //     verify(mockLocalDatasource.saveTodo(any));
    //   });
    //
    //   test('should return null when remote data could be saved', () async {
    //     // arrange
    //     when(mockRemoteDatasource.saveTodo(any)).thenAnswer((_) async => tTodoModel);
    //     when(mockLocalDatasource.getTodos()).thenAnswer((_) => Stream.value(tTodoList));
    //
    //     // act
    //     final result = await repository.saveTodo(tTodoModel);
    //
    //     // assert
    //     verify(mockRemoteDatasource.saveTodo(tTodoModel));
    //     verify(mockLocalDatasource.saveTodo(tTodoModel));
    //     expect(result, isNull);
    //   });
    // });
    //
    // group('device is offline', () {
    //   setUp(() {
    //     when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    //   });
    //
    //   test('should return NoInternetConnectionFailure', () async {
    //     // act
    //     final result = await repository.saveTodo(tTodoModel);
    //
    //     // assert
    //     verifyZeroInteractions(mockRemoteDatasource);
    //     verifyZeroInteractions(mockLocalDatasource);
    //     expect(result, NoInternetConnectionFailure());
    //   });
    // });
  });
}
