import 'package:flutter/material.dart';
import 'package:todo_clean/core/constants/routes.dart' as routes;
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/presentation/pages/todos/widgets/todo_item_widget.dart';

class TodosDisplay extends StatelessWidget {
  final List<Todo> todos;

  const TodosDisplay({
    required this.todos,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => GestureDetector(
        child: TodoItemWidget(
          todo: todos[index],
          onDelete: () {},
          checkboxToggled: (_) {},
        ),
        onTap: () => Navigator.of(context).pushNamed(
          routes.todoEditPageRoute,
          arguments: todos[index],
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 0),
      itemCount: todos.length,
    );
  }
}
