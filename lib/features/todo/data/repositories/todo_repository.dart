import 'package:dartz/dartz.dart';
import 'package:todo_clean/core/error/exceptions.dart';
import 'package:todo_clean/core/error/failures.dart';
import 'package:todo_clean/core/network/network_info.dart';
import 'package:todo_clean/features/todo/data/local_datasources/todo_local_datascource.dart';
import 'package:todo_clean/features/todo/data/remote_datasources/todo_remote_datasource.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';
import 'package:todo_clean/features/todo/domain/repositories/todo_repository_interface.dart';

class TodoRepository implements ITodoRepository {
  final ITodoRemoteDatasource remoteDatasource;
  final ITodoLocalDatasource localDatasource;
  final INetworkInfo networkInfo;

  TodoRepository({
    required this.remoteDatasource,
    required this.localDatasource,
    required this.networkInfo,
  });

  @override
  Stream<List<Todo>> getTodos() {
    return localDatasource.getTodos().map((todos) {
      return todos.map((table) => table.mapToEntity()).toList();
    });
  }

  @override
  Future<Failure?> refreshTodos() async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remoteTodos = await remoteDatasource.getTodos();
        await localDatasource.saveTodos(remoteTodos);
        return null;
      } on ServerException {
        return ServerFailure();
      }
    } else {
      return NoInternetConnectionFailure();
    }
  }

  @override
  Future<void> saveTodo(Todo todo) {
    return localDatasource.saveTodo(todo);
  }

  @override
  Future<Either<List<Todo>, Failure>> deleteTodo(int id) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  Future<Either<List<Todo>, Failure>> markCompleted(int id) {
    // TODO: implement markCompleted
    throw UnimplementedError();
  }
}
