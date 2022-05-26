import 'package:chopper/chopper.dart';

part 'todo_api.chopper.dart';

@ChopperApi()
abstract class TodoApi extends ChopperService {
  @Get(path: 'todos')
  Future<Response<dynamic>> getTodos();

  @Post(path: 'todos')
  Future<Response<dynamic>> createTodo(@Body() String data);

  static TodoApi create([ChopperClient? client]) => _$TodoApi(client);
}
