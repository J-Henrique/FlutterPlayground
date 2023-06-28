import 'dart:async';

import 'package:protos/protos.dart';

class MyHomePageRepository {
  late ClientChannel _channel;
  late TodoServiceClient _todoService;

  Stream<Todo> loadTodosStream() {
    _channel = ClientChannel(
      '10.0.2.2',
      port: 8080,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    _todoService = TodoServiceClient(_channel);
    return _todoService.getTodoStream(GetTodoByIdRequest());
  }
}