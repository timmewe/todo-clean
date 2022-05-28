import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/presentation/pages/edit/bloc/todo_edit_bloc.dart';

import '../../widgets/loading_display.dart';

class TodoEditPage extends StatefulWidget {
  final Todo? todo;

  const TodoEditPage({this.todo, Key? key}) : super(key: key);

  @override
  State<TodoEditPage> createState() => _TodoEditPageState();
}

class _TodoEditPageState extends State<TodoEditPage> {
  @override
  Widget build(BuildContext context) {
    return buildScaffold();
  }

  BlocProvider<TodoEditBloc> buildScaffold() {
    return BlocProvider<TodoEditBloc>(
      create: (_) => TodoEditBloc()..add(TodoEditSetup(todo: widget.todo)),
      child: BlocBuilder<TodoEditBloc, TodoEditState>(
        builder: (context, state) {
          if (state is TodoEditInitial) {
            return Scaffold(
              appBar: AppBar(),
              body: const LoadingDisplay(),
            );
          } else {
            return const LoadingDisplay();
          }
        },
      ),
    );
  }
}
