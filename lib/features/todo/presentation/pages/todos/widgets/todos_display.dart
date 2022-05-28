import 'package:flutter/material.dart';
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
      itemBuilder: (context, index) => TodoItemWidget(
        todo: todos[index],
        onDelete: () {},
        checkboxToggled: (_) {},
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 0),
      itemCount: todos.length,
    );
  }
}
