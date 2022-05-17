import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_clean/features/todo/data/models/todo_model.dart';
import 'package:todo_clean/features/todo/domain/entities/todo.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tTodoModel =
      TodoModel(id: 1, title: "delectus aut autem", completed: false);

  test("Should be a subclass of Todo entity", () async {
    // assert
    expect(tTodoModel, isA<Todo>());
  });

  test("fromJson should return a valid model", () async {
    // arrange
    final jsonMap = jsonDecode(fixture("todo.json")) as Map<String, dynamic>;

    // act
    final result = TodoModel.fromJson(jsonMap);

    // assert
    expect(result, tTodoModel);
  });

  test("toJson should return a valid json map containing the proper data",
      () async {
    // act
    final result = tTodoModel.toJson();

    // assert
    final expectedMap = {
      'id': 1,
      'title': 'delectus aut autem',
      'completed': false
    };
    expect(result, expectedMap);
  });
}
