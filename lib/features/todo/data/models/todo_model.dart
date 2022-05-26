import 'package:todo_clean/features/todo/domain/entities/todo.dart';

class TodoModel extends Todo {
  const TodoModel({
    required int id,
    required String title,
    required bool completed,
  }) : super(id: id, title: title, completed: completed);

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json["id"] as int,
      title: json["title"] as String,
      completed: json["completed"] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
    };
  }

  factory TodoModel.fromTodoEntity(Todo todo) {
    return TodoModel(
      id: todo.id,
      title: todo.title,
      completed: todo.completed,
    );
  }
}
