import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_clean/features/todo/data/local_datasources/hive_todo_local_datasource.dart';
import 'package:todo_clean/features/todo/data/local_datasources/todo_db.dart';
import 'package:todo_clean/features/todo/data/remote_datasources/todo_raw.dart';

import 'hive_todo_local_datasource_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  late HiveTodoLocalDatasource todoLocalDatasource;
  late MockBox<TodoDb> mockBox;

  setUp(() async {
    mockBox = MockBox();
    todoLocalDatasource = HiveTodoLocalDatasource(box: mockBox);
  });

  group('saveTodos', () {
    final tTodoModelList = [const TodoRaw(id: 0, title: 'Test', completed: false)];

    test('should call Hive to save data', () async {
      // arrange
      when(mockBox.putAll(any)).thenAnswer((_) async => [0]);

      // act
      await todoLocalDatasource.saveTodos(tTodoModelList);

      // assert
      final expectedTodoTableMap = {0: const TodoDb(id: 0, title: 'Test', completed: false)};
      verify(mockBox.putAll(expectedTodoTableMap));
    });
  });

  group('saveTodo', () {
    group('Update existing todo', () {
      const tTodoModel = TodoRaw(id: 0, title: 'Test', completed: false);
      const tTodoTable = TodoDb(id: 0, title: 'Test', completed: false);

      test('should call put to update todo', () async {
        // arrange
        when(mockBox.put(any, any)).thenAnswer((_) async => 0);

        // act
        await todoLocalDatasource.saveTodo(tTodoModel);

        // assert
        verify(mockBox.put(tTodoTable.id, tTodoTable));
      });
    });

    group('Create new todo', () {
      const tTodoModel = TodoRaw(id: -1, title: 'Test', completed: false);
      const tTodoTable = TodoDb(id: -1, title: 'Test', completed: false);
      const tTodoTableAfterUpdate = TodoDb(id: 0, title: 'Test', completed: false);

      test('should call add to save todo and update todo with autoincremented key', () async {
        // arrange
        when(mockBox.add(any)).thenAnswer((_) async => 0);

        // act
        await todoLocalDatasource.saveTodo(tTodoModel);

        // assert
        verify(mockBox.add(tTodoTable));
        verify(mockBox.put(0, tTodoTableAfterUpdate));
      });
    });
  });
}
