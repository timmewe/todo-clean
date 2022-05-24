import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean/features/todo/presentation/bloc/todos_bloc.dart';
import 'package:todo_clean/features/todo/presentation/widgets/widgets.dart';
import 'package:todo_clean/injection_container.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: buildBody(),
    );
  }

  BlocProvider<TodosBloc> buildBody() {
    return BlocProvider<TodosBloc>(
      create: (_) => TodosBloc(getTodos: serviceLocator()),
      child: BlocBuilder<TodosBloc, TodosState>(
        builder: (context, state) {
          if (state is TodosInitial) {
            return const MessageDisplay(message: 'No todos here yet...');
          } else if (state is TodosLoadError) {
            return MessageDisplay(message: state.errorMessage);
          } else if (state is TodosLoading) {
            return const LoadingDisplay();
          } else if (state is TodosLoaded) {
            return TodosDisplay(todos: state.todos);
          } else {
            return const MessageDisplay(message: 'No todos here yet...');
          }
        },
      ),
    );
  }
}
