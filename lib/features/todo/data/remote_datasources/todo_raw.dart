import 'package:todo_clean/features/todo/domain/entities/todo.dart';

class TodoRaw extends Todo {
  const TodoRaw({
    required int id,
    required String title,
    required bool completed,
  }) : super(id: id, title: title, completed: completed);

  factory TodoRaw.fromJson(Map<String, dynamic> json) {
    return TodoRaw(
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
}
