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
  final int? id;
  final String name;
  final bool completed;

  const TodoEditSave({required this.id, required this.name, this.completed = false});

  @override
  List<Object> get props => [name, completed];
}
