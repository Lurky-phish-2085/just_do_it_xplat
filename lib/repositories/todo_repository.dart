import 'package:drift/drift.dart';
import 'package:just_do_it_xplat/database/database.dart';

class TodoRepository {
  TodoRepository(this._database);

  final AppDatabase _database;

  Stream<List<TodoItemModelData>> todos() =>
      _database.select(_database.todoItemModel).watch();

  Future<int> insert(Insertable<TodoItemModelData> todo) =>
      _database.into(_database.todoItemModel).insert(todo);

  Future<bool> update(Insertable<TodoItemModelData> todo) =>
      _database.update(_database.todoItemModel).replace(todo);

  Future<int> delete(Insertable<TodoItemModelData> todo) =>
      _database.delete(_database.todoItemModel).delete(todo);
}
