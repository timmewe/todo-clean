import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';

part 'todo_edit_event.dart';
part 'todo_edit_state.dart';

class TodoEditBloc extends Bloc<TodoEditEvent, TodoEditState> {
  TodoEditBloc() : super(TodoEditInitial()) {
    on<TodoEditSetup>(_onSetup);
  }

  Future<void> _onSetup(TodoEditSetup event, Emitter<TodoEditState> emit) async {
    if (event.todo != null) {
      emit(TodoEditExisting(todo: event.todo!));
    } else {
      emit(TodoEditCreateNew());
    }
  }
}
