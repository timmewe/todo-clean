import 'dart:convert';

import 'package:todo_clean/core/api/todo_api.dart';
import 'package:todo_clean/core/error/exceptions.dart';
import 'package:todo_clean/features/todo/data/remote_datasources/todo_raw.dart';
import 'package:todo_clean/features/todo/data/remote_datasources/todo_remote_datasource.dart';

class ChopperTodoRemoteDatasource implements ITodoRemoteDatasource {
  final TodoApi api;

  ChopperTodoRemoteDatasource({required this.api});

  @override
  Future<List<TodoRaw>> getTodos() async {
    final response = await api.getTodos();
    if (response.statusCode == 200) {
      final todoJsonList = jsonDecode(response.body.toString()) as List<dynamic>;
      final todoList = todoJsonList.map((json) {
        return TodoRaw.fromJson(json as Map<String, dynamic>);
      }).toList();
      return todoList.take(5).toList();
    } else {
      throw ServerException();
    }
  }
}
