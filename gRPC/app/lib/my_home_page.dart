import 'package:flutter/material.dart';
import 'package:protos/protos.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ClientChannel _channel;
  late TodoServiceClient _stub;
  Todo? todo;
  Stream<Todo>? _todoStream;

  @override
  void initState() {
    super.initState();
    _channel = ClientChannel(
      '10.0.2.2',
      port: 8080,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    _stub = TodoServiceClient(_channel);
    _todoStream = _stub.getTodoStream(GetTodoByIdRequest(id: 1));
  }

  _getTodo() async {
    _todoStream = null;
    // final id = Random().nextInt(100);
    // final todo = await _stub.getTodo(GetTodoByIdRequest(id: id));
    // setState(() {
    //   this.todo = todo;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
              stream: _todoStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  final todo = snapshot.data as Todo;
                  return Column(
                    children: [
                      Text(todo.id.toString()),
                      Text(todo.title),
                      Text(todo.completed.toString()),
                    ],
                  );
                } else {
                  return const Text("Loading...");
                }
              },
            )
            // if (todo != null)
            //   Column(
            //     children: [
            //       Text(todo!.id.toString()),
            //       Text(todo!.title),
            //       Text(todo!.completed.toString()),
            //     ],
            //   )
            // else
            //   const Text("Get your Todo!")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getTodo,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}