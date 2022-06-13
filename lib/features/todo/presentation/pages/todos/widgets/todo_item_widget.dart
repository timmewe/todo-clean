import 'package:flutter/material.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';

class TodoItemWidget extends StatelessWidget {
  final Todo todo;
  final VoidCallback onDelete;
  final void Function(bool?) checkboxToggled;

  const TodoItemWidget({
    required this.todo,
    required this.onDelete,
    required this.checkboxToggled,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      subtitle: Text(todo.id.toString()),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
          Checkbox(value: todo.completed, onChanged: checkboxToggled),
        ],
      ),
    );
  }
}
