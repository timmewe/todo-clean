import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_clean/core/error/failures.dart';
import 'package:todo_clean/core/usecases/use_case_interface.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/domain/usecases/get_todos_usecase.dart';
import 'package:todo_clean/features/todo/domain/usecases/refresh_todos_usecase.dart';

part 'todos_event.dart';
part 'todos_state.dart';

const String serverFailureMessage = 'Server Fail';
const String databaseFailureMessage = 'Server Fail';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final GetTodosUsecase getTodos;
  final RefreshTodosUsecase refreshTodos;

  TodosBloc({required this.getTodos, required this.refreshTodos}) : super(const TodosState()) {
    on<TodosSubscriptionRequested>(_onGetTodos);
    on<RefreshTodos>(_onRefreshTodos);

    // add(GetTodos());
  }

  Future<void> _onGetTodos(TodosSubscriptionRequested event, Emitter<TodosState> emit) async {
    emit(const TodosState(status: TodosStatus.loading));
    final todosStream = getTodos(NoParams());
    await emit.forEach(
      todosStream,
      onData: (List<Todo> todos) {
        if (todos.isEmpty) {
          return const TodosState(
            status: TodosStatus.failure,
            message: 'No todos found, please add one...',
          );
        }
        return TodosState(status: TodosStatus.success, todos: todos);
      },
    );
  }

  Future<void> _onRefreshTodos(RefreshTodos event, Emitter<TodosState> emit) async {
    final failure = await refreshTodos(NoParams());
    if (failure != null) {
      emit(state.copyWith(message: failure.message));
    }
  }
}
