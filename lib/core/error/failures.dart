import 'package:equatable/equatable.dart';
import 'package:todo_clean/features/todo/presentation/pages/todos/bloc/todos_bloc.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

extension FailureMessage on Failure {
  String get message {
    switch (runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case DatabaseFailure:
        return databaseFailureMessage;
      default:
        return 'Unexpected error';
    }
  }
}

class ServerFailure extends Failure {}

class DatabaseFailure extends Failure {}

class NoInternetConnectionFailure extends Failure {}
