import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/presentation/pages/edit/bloc/todo_edit_bloc.dart';
import 'package:todo_clean/features/todo/presentation/pages/edit/widgets/todo_edit_display.dart';
import 'package:todo_clean/injection_container.dart';

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
      create: (_) => TodoEditBloc(saveTodo: serviceLocator())..add(TodoEditSetup(todo: todo)),
      child: BlocConsumer<TodoEditBloc, TodoEditState>(
        listenWhen: (previous, current) => current is TodoEditSaveSuccess,
        listener: (context, state) {
          if (state is TodoEditSaveSuccess) {
            Navigator.of(context).pop();
            const snackBar = SnackBar(
              content: Text('Success'),
              backgroundColor: Colors.green,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        buildWhen: (previous, current) {
          return current is! TodoEditSaveFailure || current is! TodoEditSaveSuccess;
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.appBarTitle),
            ),
            body: _buildBody(context: context, state: state),
          );
        },
      ),
    );
  }

  Widget _buildBody({required BuildContext context, required TodoEditState state}) {
    if (state is TodoEditCreateNew) {
      return TodoEditDisplay();
    } else if (state is TodoEditExisting) {
      return TodoEditDisplay(
        todo: state.todo,
      );
    } else if (state is TodoEditLoading) {
      return TodoEditDisplay(todo: state.todo, loading: true);
    } else {
      return TodoEditDisplay();
    }
  }
}
