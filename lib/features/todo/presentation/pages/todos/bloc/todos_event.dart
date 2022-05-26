part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();
}

class GetTodos extends TodosEvent {
  @override
  List<Object?> get props => [];
}
