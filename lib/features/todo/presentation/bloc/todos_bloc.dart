import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosInitial()) {
    on<TodosEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
