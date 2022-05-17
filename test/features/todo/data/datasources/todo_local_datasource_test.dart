import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_clean/core/error/exceptions.dart';
import 'package:todo_clean/features/todo/data/datasources/hive_todo_local_datasource.dart';
import 'package:todo_clean/features/todo/data/models/todo_model.dart';
import 'package:todo_clean/features/todo/data/tables/todo_table.dart';

import 'todo_local_datasource_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  late HiveTodoLocalDatasource todoLocalDatasource;
  late MockBox<TodoTable> mockBox;

  setUp(() async {
    mockBox = MockBox();
    todoLocalDatasource = HiveTodoLocalDatasource(box: mockBox);
  });

  group('getTodos', () {
    final tTodoModelList = [const TodoModel(id: 0, title: 'Test', completed: false)];
    final tTodoTableList = [const TodoTable(id: 0, title: 'Test', completed: false)];

    test('should return List of Todo from hive when todos are stored', () async {
      // arrange
      when(mockBox.values).thenAnswer((_) => tTodoTableList);

      // act
      final result = await todoLocalDatasource.getTodos();

      // assert
      verify(mockBox.values);
      expect(result, tTodoModelList);
    });

    test('should throw a LocalDatabaseException when no todos are stored', () async {
      // arrange
      when(mockBox.values).thenReturn([]);

      // act
      final call = todoLocalDatasource.getTodos;

      // assert
      expect(call, throwsA(const TypeMatcher<DatabaseException>()));
    });
  });

  group('saveTodos', () {
    final tTodoModelList = [const TodoModel(id: 0, title: 'Test', completed: false)];

    test('should call Hive to save data', () async {
      // arrange
      when(mockBox.addAll(any)).thenAnswer((_) async => [0]);

      // act
      await todoLocalDatasource.saveTodos(tTodoModelList);

      // assert
      final expectedTodoTableList = [const TodoTable(id: 0, title: 'Test', completed: false)];
      verify(mockBox.addAll(expectedTodoTableList));
    });
  });
}
