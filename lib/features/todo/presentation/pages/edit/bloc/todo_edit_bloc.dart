import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/domain/usecases/save_todo_usecase.dart';

part 'todo_edit_event.dart';
part 'todo_edit_state.dart';

class TodoEditBloc extends Bloc<TodoEditEvent, TodoEditState> {
  final SaveTodoUsecase saveTodo;

  TodoEditBloc({required this.saveTodo}) : super(TodoEditInitial()) {
    on<TodoEditSetup>(_onSetup);
    on<TodoEditSave>(_onSave);
  }

  Future<void> _onSetup(TodoEditSetup event, Emitter<TodoEditState> emit) async {
    if (event.todo != null) {
      emit(TodoEditExisting(todo: event.todo!));
    } else {
      emit(TodoEditCreateNew());
    }
  }

  Future<void> _onSave(TodoEditSave event, Emitter<TodoEditState> emit) async {
    emit(TodoEditLoading(todo: event.todo));
    await saveTodo(Params(todo: event.todo));
    emit(TodoEditSaveSuccess());
  }
}
