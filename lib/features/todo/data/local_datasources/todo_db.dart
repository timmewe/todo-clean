import 'package:hive/hive.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';

part 'todo_db.g.dart';

@HiveType(typeId: 0)
class TodoDb extends Todo {
  @override
  @HiveField(0)
  final int id;

  @override
  @HiveField(1)
  final String title;

  @override
  @HiveField(2)
  final bool completed;

  const TodoDb({
    required this.id,
    required this.title,
    required this.completed,
  }) : super(id: id, title: title, completed: completed);

  Todo mapToEntity() {
    return Todo(id: id, title: title, completed: completed);
  }
}
