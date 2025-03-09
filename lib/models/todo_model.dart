class TodoData {
  TodoData(this.task, {this.checked = false});

  final String task;
  bool checked;

  bool toggleCheck() {
    checked = !checked;

    return checked;
  }

  @override
  String toString() {
    return 'Item(name: $task, checked: $checked)';
  }
}

class TodoModel {
  final _items = <TodoData>[];

  Iterable<TodoData> findAll() {
    return _items;
  }

  TodoData create(TodoData todo) {
    _items.add(todo);

    return todo;
  }

  bool delete(TodoData item) {
    return _items.remove(item);
  }
}
