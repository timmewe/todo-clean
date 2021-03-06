part of 'todo_edit_bloc.dart';

abstract class TodoEditState extends Equatable {
  String get appBarTitle => '';

  @override
  List<Object> get props => [appBarTitle];
}

class TodoEditInitial extends TodoEditState {}

class TodoEditCreateNew extends TodoEditState {
  @override
  String get appBarTitle => 'Create todo';
}

class TodoEditExisting extends TodoEditState {
  final Todo todo;

  TodoEditExisting({required this.todo});

  @override
  String get appBarTitle => 'Edit todo';

  @override
  List<Object> get props => [todo];
}

class TodoEditLoading extends TodoEditState {
  final Todo todo;

  TodoEditLoading({required this.todo});

  @override
  List<Object> get props => [todo];
}

class TodoEditSaveSuccess extends TodoEditState {}

class TodoEditSaveFailure extends TodoEditState {
  final String message;

  TodoEditSaveFailure({required this.message});

  @override
  List<Object> get props => [message];
}
