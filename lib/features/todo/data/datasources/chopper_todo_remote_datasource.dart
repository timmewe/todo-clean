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
      return todoList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TodoModel> addTodo(TodoModel todo) async {
    final response = await api.createTodo(todo.toJson().toString());
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body.toString()) as Map<String, dynamic>;
      final createdTodo = TodoModel.fromJson(json);
      return createdTodo;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> deleteTodo(int id) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  Future<TodoModel> markCompleted(int id) {
    // TODO: implement markCompleted
    throw UnimplementedError();
  }
}
