import 'package:dartz/dartz.dart';
import 'package:todo_clean/core/error/exceptions.dart';
import 'package:todo_clean/core/error/failures.dart';
import 'package:todo_clean/core/network/network_info.dart';
import 'package:todo_clean/features/todo/data/datasources/todo_local_datascource.dart';
import 'package:todo_clean/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:todo_clean/features/todo/data/models/todo_model.dart';
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
    return localDatasource.getTodos();
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
  Future<Failure?> addTodo(Todo todo) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remoteTodo = await remoteDatasource.addTodo(
          TodoModel.fromTodoEntity(todo),
        );
        await localDatasource.addTodo(remoteTodo);
        return null;
      } on ServerException {
        return ServerFailure();
      }
    } else {
      return NoInternetConnectionFailure();
    }
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
