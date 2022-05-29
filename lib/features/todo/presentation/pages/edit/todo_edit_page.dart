import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/presentation/pages/edit/bloc/todo_edit_bloc.dart';
import 'package:todo_clean/features/todo/presentation/pages/edit/widgets/todo_edit_display.dart';

class TodoEditPage extends StatelessWidget {
  final Todo? todo;

  const TodoEditPage({
    this.todo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildScaffold();
  }

  BlocProvider<TodoEditBloc> buildScaffold() {
    return BlocProvider<TodoEditBloc>(
      create: (_) => TodoEditBloc()..add(TodoEditSetup(todo: todo)),
      child: BlocBuilder<TodoEditBloc, TodoEditState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.appBarTitle),
            ),
            body: _buildBody(state: state),
          );
        },
      ),
    );
  }

  Widget _buildBody({required TodoEditState state}) {
    if (state is TodoEditCreateNew) {
      return TodoEditDisplay();
    } else if (state is TodoEditExisting) {
      return TodoEditDisplay(todo: state.todo);
    } else {
      return TodoEditDisplay();
    }
  }
}
