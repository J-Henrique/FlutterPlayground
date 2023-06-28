import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:protos/protos.dart';

class MyHomePageStreaming extends Equatable {
  final List<Todo> todoList;
  final bool showButton;
  const MyHomePageStreaming(this.todoList, this.showButton);

  MyHomePageStreaming copyWith(List<Todo>? list, bool? showButton) {
    debugPrint("List size: ${list?.length.toString()}");
    return MyHomePageStreaming(list ?? todoList, showButton ?? this.showButton);
  }

  @override
  List<Object?> get props => [todoList, showButton];
}
