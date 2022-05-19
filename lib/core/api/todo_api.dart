import 'package:chopper/chopper.dart';

part 'todo_api.chopper.dart';

@ChopperApi()
abstract class TodoApi extends ChopperService {
  @Get(path: 'todos')
  Future<Response<dynamic>> getTodos();

  static TodoApi create([ChopperClient? client]) => _$TodoApi(client);
}
