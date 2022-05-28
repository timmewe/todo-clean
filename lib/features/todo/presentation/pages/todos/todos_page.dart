import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean/features/todo/presentation/pages/todos/bloc/todos_bloc.dart';
import 'package:todo_clean/features/todo/presentation/pages/todos/widgets/add_todo_button.dart';
import 'package:todo_clean/features/todo/presentation/pages/todos/widgets/message_display.dart';
import 'package:todo_clean/features/todo/presentation/pages/todos/widgets/todos_display.dart';
import 'package:todo_clean/features/todo/presentation/widgets/loading_display.dart';
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
      floatingActionButton: const AddTodoButton(),
    );
  }

  BlocProvider<TodosBloc> buildBody() {
    return BlocProvider<TodosBloc>(
      create: (_) => TodosBloc(getTodos: serviceLocator(), refreshTodos: serviceLocator())
        ..add(TodosSubscriptionRequested())
        ..add(RefreshTodos()),
      child: BlocBuilder<TodosBloc, TodosState>(
        builder: (context, state) {
          if (state.status == TodosStatus.initial) {
            return const MessageDisplay(message: 'No todos here yet...');
          } else if (state.status == TodosStatus.failure) {
            return MessageDisplay(message: state.message ?? 'Error');
          } else if (state.status == TodosStatus.loading) {
            return const LoadingDisplay();
          } else if (state.status == TodosStatus.success) {
            return TodosDisplay(todos: state.todos);
          } else {
            return const MessageDisplay(message: 'No todos here yet...');
          }
        },
      ),
    );
  }
}
