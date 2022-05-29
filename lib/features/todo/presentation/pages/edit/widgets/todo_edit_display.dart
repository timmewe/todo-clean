import 'package:flutter/material.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';

class TodoEditDisplay extends StatefulWidget {
  final Todo? todo;
  final TextEditingController textEditingController = TextEditingController();

  TodoEditDisplay({
    this.todo,
    Key? key,
  }) : super(key: key) {
    textEditingController
      ..text = todo?.title ?? ''
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: textEditingController.text.length),
      );
  }

  @override
  State<TodoEditDisplay> createState() => _TodoEditDisplayState();
}

class _TodoEditDisplayState extends State<TodoEditDisplay> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: widget.textEditingController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter name',
              ),
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
