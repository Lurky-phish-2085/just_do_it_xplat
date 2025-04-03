import 'package:drift/drift.dart';
import 'package:just_do_it_xplat/database/database.dart';

class TodoRepository {
  TodoRepository(this._database);

  final AppDatabase _database;

  Stream<Iterable<Todo>> todos() =>
      _database.select(_database.todoModel).watch();

  Future<int> insert(Insertable<Todo> todo) =>
      _database.into(_database.todoModel).insert(todo);

  Future<bool> update(Insertable<Todo> todo) =>
      _database.update(_database.todoModel).replace(todo);

  Future<int> delete(Insertable<Todo> todo) =>
      _database.delete(_database.todoModel).delete(todo);
}
