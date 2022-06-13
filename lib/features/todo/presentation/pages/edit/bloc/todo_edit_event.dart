part of 'todo_edit_bloc.dart';

abstract class TodoEditEvent extends Equatable {
  const TodoEditEvent();
}

class TodoEditSetup extends TodoEditEvent {
  final Todo? todo;

  const TodoEditSetup({this.todo});

  @override
  List<Object> get props => todo != null ? [todo!] : [];
}

class TodoEditSave extends TodoEditEvent {
  final Todo todo;

  const TodoEditSave({required this.todo});

  @override
  List<Object> get props => [todo];
}
