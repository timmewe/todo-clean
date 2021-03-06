import 'package:chopper/chopper.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todo_clean/core/api/todo_api.dart';
import 'package:todo_clean/core/network/network_info.dart';
import 'package:todo_clean/features/todo/data/local_datasources/hive_todo_local_datasource.dart';
import 'package:todo_clean/features/todo/data/local_datasources/todo_db.dart';
import 'package:todo_clean/features/todo/data/local_datasources/todo_local_datascource.dart';
import 'package:todo_clean/features/todo/data/remote_datasources/chopper_todo_remote_datasource.dart';
import 'package:todo_clean/features/todo/data/remote_datasources/todo_remote_datasource.dart';
import 'package:todo_clean/features/todo/data/repositories/todo_repository.dart';
import 'package:todo_clean/features/todo/domain/usecases/get_todos_usecase.dart';
import 'package:todo_clean/features/todo/domain/usecases/refresh_todos_usecase.dart';
import 'package:todo_clean/features/todo/domain/usecases/save_todo_usecase.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> init() async {
  _initFeatures();
  _initCore();
  await _initExternal();
}

void _initFeatures() {
  serviceLocator
    ..registerLazySingleton<ITodoRemoteDatasource>(
      () => ChopperTodoRemoteDatasource(api: serviceLocator<TodoApi>()),
    )
    ..registerLazySingleton<ITodoLocalDatasource>(
      () => HiveTodoLocalDatasource(box: serviceLocator()),
    )
    ..registerLazySingleton<IGetTodosUseCaseDatasource>(
      () => TodoRepository(
        remoteDatasource: serviceLocator(),
        localDatasource: serviceLocator(),
        networkInfo: serviceLocator(),
      ),
    )
    ..registerLazySingleton<IRefreshTodosUseCaseDatasource>(
      () => TodoRepository(
        remoteDatasource: serviceLocator(),
        localDatasource: serviceLocator(),
        networkInfo: serviceLocator(),
      ),
    )
    ..registerLazySingleton<ISaveTodoUseCaseDatasource>(
      () => TodoRepository(
        remoteDatasource: serviceLocator(),
        localDatasource: serviceLocator(),
        networkInfo: serviceLocator(),
      ),
    )
    ..registerLazySingleton<GetTodosUsecase>(() => GetTodosUsecase(serviceLocator()))
    ..registerLazySingleton<RefreshTodosUsecase>(() => RefreshTodosUsecase(serviceLocator()))
    ..registerLazySingleton<SaveTodoUsecase>(() => SaveTodoUsecase(serviceLocator()));
}

void _initCore() {
  serviceLocator.registerLazySingleton<INetworkInfo>(() => NetworkInfo(serviceLocator()));
  _initChopper();
}

void _initChopper() {
  final chopper = ChopperClient(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    interceptors: [
      HttpLoggingInterceptor(),
    ],
    services: [
      TodoApi.create(),
    ],
  );

  serviceLocator.registerLazySingleton<TodoApi>(() => TodoApi.create(chopper));
}

Future<void> _initExternal() async {
  final todoBox = await Hive.openBox<TodoDb>('name');
  serviceLocator
    ..registerLazySingleton<Box<TodoDb>>(() => todoBox)
    ..registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker(),
    );
}
