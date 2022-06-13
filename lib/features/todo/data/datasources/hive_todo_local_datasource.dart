import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_clean/features/todo/data/datasources/todo_local_datascource.dart';
import 'package:todo_clean/features/todo/data/tables/todo_table.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';

class HiveTodoLocalDatasource implements ITodoLocalDatasource {
  final Box<TodoTable> box;

  HiveTodoLocalDatasource({required this.box});

  @override
  Stream<List<Todo>> getTodos() {
    return box.watch().map((_) => box.values.toList()).startWith(box.values.toList());
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
    await box.putAll(Map.fromEntries(todoTables.map((t) => MapEntry(t.id, t))));
  }

  @override
  Future<void> saveTodo(Todo todo) async {
    final todoTable = TodoTable(
      id: todo.id,
      title: todo.title,
      completed: todo.completed,
    );
    if (todoTable.id == -1) {
      final id = await box.add(todoTable);
      await box.put(id, TodoTable(id: id, title: todo.title, completed: todo.completed));
    } else {
      await box.put(todo.id, todoTable);
    }
  }
}
