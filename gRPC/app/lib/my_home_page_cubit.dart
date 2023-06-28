import 'package:app/my_home_page_repository.dart';
import 'package:app/my_home_page_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:protos/protos.dart';

class MyHomePageCubit extends Cubit<MyHomePageStreaming> {
  MyHomePageRepository repository;

  MyHomePageCubit({required this.repository})
      : super(const MyHomePageStreaming([], false));

  void init() async {
    try {
      repository.loadTodosStream().listen((value) {
        debugPrint("Received: ${value.id}");
        List<Todo> currentList = [];
        currentList.addAll(state.todoList);
        currentList.add(value);
        emit(state.copyWith(currentList, false));
      });
    } catch (e) {
      rethrow;
    }
  }

  void showButton() {
    debugPrint("Clicked");
    emit(state.copyWith(state.todoList, true));
  }
}
