import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/presentation/pages/edit/bloc/todo_edit_bloc.dart';
import 'package:todo_clean/features/todo/presentation/widgets/loading_display.dart';

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
            return _buildInitial();
          } else {
            if (state is TodoEditCreateNew) {
              return _buildNewTodo();
            } else {
              return _buildEditTodo();
            }
          }
        },
      ),
    );
  }

  Scaffold _buildEditTodo() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit todo'),
      ),
    );
  }

  Scaffold _buildNewTodo() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New todo'),
      ),
    );
  }

  Scaffold _buildInitial() => Scaffold(appBar: AppBar(), body: const LoadingDisplay());
}
