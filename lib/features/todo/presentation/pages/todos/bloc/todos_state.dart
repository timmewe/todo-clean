part of 'todos_bloc.dart';

enum TodosStatus { initial, loading, success, failure }

class TodosState extends Equatable {
  final TodosStatus status;
  final List<Todo> todos;
  final String? message;

  const TodosState({
    this.status = TodosStatus.initial,
    this.todos = const [],
    this.message,
  });

  TodosState copyWith({
    TodosStatus? status,
    List<Todo>? todos,
    String? message,
  }) {
    return TodosState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      message: message,
    );
  }

  @override
  List<Object?> get props => [status, todos, message];
}
