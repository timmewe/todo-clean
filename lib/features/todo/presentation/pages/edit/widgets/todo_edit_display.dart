import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/presentation/pages/edit/bloc/todo_edit_bloc.dart';

class TodoEditDisplay extends StatefulWidget {
  final Todo? todo;
  final bool loading;

  final TextEditingController textEditingController = TextEditingController();

  TodoEditDisplay({
    this.todo,
    this.loading = false,
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
            if (widget.loading)
              const Center(child: CircularProgressIndicator())
            else
              ElevatedButton(
                child: const Text('Save'),
                onPressed: () {
                  final id = widget.todo?.id ?? -1;
                  final name = widget.textEditingController.text;
                  context.read<TodoEditBloc>().add(TodoEditSave(id: id, name: name));
                },
              ),
          ],
        ),
      ),
    );
  }
}
