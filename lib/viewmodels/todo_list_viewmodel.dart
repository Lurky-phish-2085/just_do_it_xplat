import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:just_do_it_xplat/database/database.dart';
import 'package:just_do_it_xplat/database/repositories/todo_repository.dart';

class TodoListViewModel extends ChangeNotifier {
  TodoListViewModel(this._repository);

  final TodoRepository _repository;
  Stream<Iterable<Todo>>? _todoList;

  Stream<Iterable<Todo>> get todos {
    _todoList ??= _repository.todos();
    return _todoList!;
  }

  Future<void> addItem(Todo item) async {
    final todo = TodoModelCompanion(title: Value(item.title));
    await _repository.insert(todo);

    notifyListeners();
  }

  Future<void> toggleCheck(Todo item) async {
    final updatedTodo = item.copyWith(done: !item.done);
    await _repository.update(updatedTodo);

    notifyListeners();
  }

  void removeItem(Todo item) async {
    await _repository.delete(item);

    notifyListeners();
  }
}
