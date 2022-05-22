import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_clean/core/error/failures.dart';
import 'package:todo_clean/core/usecases/use_case_interface.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/domain/usecases/get_todos_usecase.dart';

part 'todos_event.dart';
part 'todos_state.dart';

const String serverFailureMessage = 'Server Fail';
const String databaseFailureMessage = 'Server Fail';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final GetTodosUsecase getTodos;

  TodosBloc({required this.getTodos}) : super(TodosInitial()) {
    on<GetTodos>(_onGetTodos);
  }

  Future<void> _onGetTodos(GetTodos event, Emitter<TodosState> emit) async {
    emit(TodosLoading());
    final todosOrFailure = await getTodos(NoParams());
    final todosOrFailureState = todosOrFailure.fold(
      (todos) => TodosLoaded(todos: todos),
      (failure) => TodosLoadError(errorMessage: failure.message),
    );
    emit(todosOrFailureState);
  }
}
