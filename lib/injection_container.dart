import 'package:chopper/chopper.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todo_clean/core/api/todo_api.dart';
import 'package:todo_clean/core/network/network_info.dart';
import 'package:todo_clean/features/todo/data/datasources/chopper_todo_remote_datasource.dart';
import 'package:todo_clean/features/todo/data/datasources/hive_todo_local_datasource.dart';
import 'package:todo_clean/features/todo/data/datasources/todo_local_datascource.dart';
import 'package:todo_clean/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:todo_clean/features/todo/data/repositories/todo_repository.dart';
import 'package:todo_clean/features/todo/data/tables/todo_table.dart';
import 'package:todo_clean/features/todo/domain/repositories/todo_repository_interface.dart';
import 'package:todo_clean/features/todo/domain/usecases/get_todos_usecase.dart';
import 'package:todo_clean/features/todo/presentation/bloc/todos_bloc.dart';

final GetIt serviceLocator = GetIt.instance;

void init() {
  _initFeatures();
  _initCore();
  _initExternal();
}

void _initFeatures() {
  serviceLocator
    ..registerFactory(() => TodosBloc(getTodos: serviceLocator()))
    ..registerLazySingleton(() => GetTodosUsecase(serviceLocator()))
    ..registerLazySingleton<ITodoRepository>(
      () => TodoRepository(
        remoteDatasource: serviceLocator(),
        localDatasource: serviceLocator(),
        networkInfo: serviceLocator(),
      ),
    )
    ..registerLazySingleton<ITodoRemoteDatasource>(
      () => ChopperTodoRemoteDatasource(api: serviceLocator()),
    )
    ..registerLazySingleton<ITodoLocalDatasource>(
      () => HiveTodoLocalDatasource(box: serviceLocator()),
    );
}

void _initCore() {
  serviceLocator.registerLazySingleton<INetworkInfo>(() => NetworkInfo(serviceLocator()));
  _initChopper();
}

void _initChopper() {
  final chopper = ChopperClient(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    services: [
      TodoApi.create(),
    ],
  );

  serviceLocator.registerSingleton(() => TodoApi.create(chopper));
}

void _initExternal() {
  serviceLocator
    ..registerLazySingletonAsync(() async => Hive.openBox<TodoTable>('name'))
    ..registerLazySingleton(() => InternetConnectionChecker());
}
