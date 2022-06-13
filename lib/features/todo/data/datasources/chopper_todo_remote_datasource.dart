import 'dart:convert';

import 'package:todo_clean/core/api/todo_api.dart';
import 'package:todo_clean/core/error/exceptions.dart';
import 'package:todo_clean/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:todo_clean/features/todo/data/models/todo_model.dart';

class ChopperTodoRemoteDatasource implements ITodoRemoteDatasource {
  final TodoApi api;

  ChopperTodoRemoteDatasource({required this.api});

  @override
  Future<List<TodoModel>> getTodos() async {
    final response = await api.getTodos();
    if (response.statusCode == 200) {
      final todoJsonList = jsonDecode(response.body.toString()) as List<dynamic>;
      final todoList =
          todoJsonList.map((json) => TodoModel.fromJson(json as Map<String, dynamic>)).toList();
      return todoList.take(5).toList();
    } else {
      throw ServerException();
    }
  }
}
