part of 'todo_edit_bloc.dart';

abstract class TodoEditState extends Equatable {
  const TodoEditState();

  @override
  List<Object> get props => [];
}

class TodoEditInitial extends TodoEditState {}

class TodoEditCreateNew extends TodoEditState {}

class TodoEditExisting extends TodoEditState {
  final Todo todo;

  const TodoEditExisting({required this.todo});

  @override
  List<Object> get props => [todo];
}
