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
    return box.watch().map((_) => box.values.toList()).startWith([]);
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

  @override
  Future<void> addTodo(Todo todo) async {
    final todoTable = TodoTable(
      id: todo.id,
      title: todo.title,
      completed: todo.completed,
    );
    await box.add(todoTable);
  }
}
