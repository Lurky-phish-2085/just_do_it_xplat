import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:just_do_it_xplat/database/database.dart';
import 'package:just_do_it_xplat/models/todo_model.dart';
import 'package:just_do_it_xplat/repositories/todo_repository.dart';

class TodoListViewModel extends ChangeNotifier {
  TodoListViewModel(this._repository);

  final TodoRepository _repository;
  Stream<List<TodoItemModelData>>? _todoList;

  Stream<List<TodoItemModelData>> get todos {
    _todoList ??= _repository.todos();
    return _todoList!;
  }

  Future<void> addItem(TodoData item) async {
    final todo = TodoItemModelCompanion(title: Value(item.task));
    await _repository.insert(todo);

    notifyListeners();
  }

  Future<void> toggleCheck(TodoItemModelData item) async {
    final updatedTodo = item.copyWith(done: !item.done);
    await _repository.update(updatedTodo);

    notifyListeners();
  }

  void removeItem(TodoItemModelData item) async {
    await _repository.delete(item);

    notifyListeners();
  }
}
