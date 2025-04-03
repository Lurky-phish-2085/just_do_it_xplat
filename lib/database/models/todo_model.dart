import 'package:drift/drift.dart';

@DataClassName('Todo')
class TodoModel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 32)();
  BoolColumn get done => boolean().withDefault(Constant(false))();
  DateTimeColumn get createdAt => dateTime().nullable()();
}
