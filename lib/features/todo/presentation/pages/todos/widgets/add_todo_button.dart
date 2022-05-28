import 'package:flutter/material.dart';
import 'package:todo_clean/core/constants/routes.dart' as routes;

class AddTodoButton extends StatelessWidget {
  const AddTodoButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () => Navigator.of(context).pushNamed(routes.todoEditPageRoute),
    );
  }
}
