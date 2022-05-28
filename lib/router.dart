import 'package:flutter/material.dart';
import 'package:todo_clean/core/constants/routes.dart' as routes;
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/presentation/pages/edit/todo_edit_page.dart';
import 'package:todo_clean/features/todo/presentation/pages/todos/todos_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.todosPageRoute:
      return MaterialPageRoute(builder: (_) => const TodosPage());
    case routes.todoEditPageRoute:
      final todo = settings.arguments as Todo?;
      return MaterialPageRoute(builder: (_) => TodoEditPage(todo: todo), fullscreenDialog: true);
    default:
      return MaterialPageRoute(builder: (_) => const TodosPage());
  }
}
