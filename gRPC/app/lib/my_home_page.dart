import 'package:app/my_home_page_cubit.dart';
import 'package:app/my_home_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<MyHomePageCubit>()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          children: [
            BlocBuilder<MyHomePageCubit, MyHomePageStreaming>(
              builder: (context, state) {
                return Expanded(
                    child: ListView.builder(
                  itemCount: state.todoList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => context.read<MyHomePageCubit>().showButton(),
                      child: ListTile(
                        title:
                            Text("ID: ${state.todoList[index].id.toString()}"),
                        subtitle: Text(
                            "Total Items: ${state.todoList.length.toString()}"),
                      ),
                    );
                  },
                ));
              },
            )
          ],
        ),
        floatingActionButton: BlocBuilder<MyHomePageCubit, MyHomePageStreaming>(
          builder: (context, state) {
            return Visibility(
                visible: state.showButton,
                child: FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.add),
                ));
          },
        ),
      ),
    );
  }
}
