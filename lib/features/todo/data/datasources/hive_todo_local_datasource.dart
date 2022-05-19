import 'package:hive/hive.dart';
import 'package:todo_clean/core/error/exceptions.dart';
import 'package:todo_clean/features/todo/data/datasources/todo_local_datascource.dart';
import 'package:todo_clean/features/todo/data/models/todo_model.dart';
import 'package:todo_clean/features/todo/data/tables/todo_table.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';

class HiveTodoLocalDatasource implements ITodoLocalDatasource {
  final Box<TodoTable> box;

  HiveTodoLocalDatasource({required this.box});

  @override
  Future<List<Todo>> getTodos() {
    final todoTables = box.values.toList();
    if (todoTables.isEmpty) {
      throw DatabaseException();
    } else {
      final todoModels = todoTables.map((table) {
        return TodoModel(id: table.id, title: table.title, completed: table.completed);
      }).toList();
      return Future.value(todoModels);
    }
  }

  @override
  Future<void> saveTodos(List<Todo> todos) async {
    final todoTables = todos.map((todo) {
      return TodoTable(
        id: todo.id,
        title: todo.title,
        completed: todo.completed,
      );
    }).toList();
    await box.addAll(todoTables);
  }
}
