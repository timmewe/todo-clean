part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object?> get props => [];
}

class RequestTodosSubscription extends TodosEvent {}

class RefreshTodos extends TodosEvent {}
