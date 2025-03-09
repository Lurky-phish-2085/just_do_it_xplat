import 'package:flutter/material.dart';
import 'package:just_do_it_xplat/models/todo_model.dart';

class TodoListViewModel extends ChangeNotifier {
  TodoListViewModel({required this.model});

  final TodoModel model;

  Iterable<TodoData> get items => model.findAll();

  void addItem(TodoData item) {
    model.create(item);

    notifyListeners();
  }

  void toggleCheck(TodoData item) {
    item.toggleCheck();

    notifyListeners();
  }

  void removeItem(TodoData item) {
    model.delete(item);

    notifyListeners();
  }
}
