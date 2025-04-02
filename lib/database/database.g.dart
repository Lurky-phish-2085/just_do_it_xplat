// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TodoItemModelTable extends TodoItemModel
    with TableInfo<$TodoItemModelTable, TodoItemModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoItemModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 6,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _doneMeta = const VerificationMeta('done');
  @override
  late final GeneratedColumn<bool> done = GeneratedColumn<bool>(
    'done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("done" IN (0, 1))',
    ),
    defaultValue: Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, done, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todo_item_model';
  @override
  VerificationContext validateIntegrity(
    Insertable<TodoItemModelData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('done')) {
      context.handle(
        _doneMeta,
        done.isAcceptableOrUnknown(data['done']!, _doneMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoItemModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoItemModelData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      done:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}done'],
          )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $TodoItemModelTable createAlias(String alias) {
    return $TodoItemModelTable(attachedDatabase, alias);
  }
}

class TodoItemModelData extends DataClass
    implements Insertable<TodoItemModelData> {
  final int id;
  final String title;
  final bool done;
  final DateTime? createdAt;
  const TodoItemModelData({
    required this.id,
    required this.title,
    required this.done,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['done'] = Variable<bool>(done);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  TodoItemModelCompanion toCompanion(bool nullToAbsent) {
    return TodoItemModelCompanion(
      id: Value(id),
      title: Value(title),
      done: Value(done),
      createdAt:
          createdAt == null && nullToAbsent
              ? const Value.absent()
              : Value(createdAt),
    );
  }

  factory TodoItemModelData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoItemModelData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      done: serializer.fromJson<bool>(json['done']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'done': serializer.toJson<bool>(done),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  TodoItemModelData copyWith({
    int? id,
    String? title,
    bool? done,
    Value<DateTime?> createdAt = const Value.absent(),
  }) => TodoItemModelData(
    id: id ?? this.id,
    title: title ?? this.title,
    done: done ?? this.done,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  TodoItemModelData copyWithCompanion(TodoItemModelCompanion data) {
    return TodoItemModelData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      done: data.done.present ? data.done.value : this.done,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TodoItemModelData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('done: $done, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, done, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoItemModelData &&
          other.id == this.id &&
          other.title == this.title &&
          other.done == this.done &&
          other.createdAt == this.createdAt);
}

class TodoItemModelCompanion extends UpdateCompanion<TodoItemModelData> {
  final Value<int> id;
  final Value<String> title;
  final Value<bool> done;
  final Value<DateTime?> createdAt;
  const TodoItemModelCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.done = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TodoItemModelCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.done = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : title = Value(title);
  static Insertable<TodoItemModelData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<bool>? done,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (done != null) 'done': done,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TodoItemModelCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<bool>? done,
    Value<DateTime?>? createdAt,
  }) {
    return TodoItemModelCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      done: done ?? this.done,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (done.present) {
      map['done'] = Variable<bool>(done.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoItemModelCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('done: $done, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TodoItemModelTable todoItemModel = $TodoItemModelTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todoItemModel];
}

typedef $$TodoItemModelTableCreateCompanionBuilder =
    TodoItemModelCompanion Function({
      Value<int> id,
      required String title,
      Value<bool> done,
      Value<DateTime?> createdAt,
    });
typedef $$TodoItemModelTableUpdateCompanionBuilder =
    TodoItemModelCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<bool> done,
      Value<DateTime?> createdAt,
    });

class $$TodoItemModelTableFilterComposer
    extends Composer<_$AppDatabase, $TodoItemModelTable> {
  $$TodoItemModelTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get done => $composableBuilder(
    column: $table.done,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TodoItemModelTableOrderingComposer
    extends Composer<_$AppDatabase, $TodoItemModelTable> {
  $$TodoItemModelTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get done => $composableBuilder(
    column: $table.done,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TodoItemModelTableAnnotationComposer
    extends Composer<_$AppDatabase, $TodoItemModelTable> {
  $$TodoItemModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<bool> get done =>
      $composableBuilder(column: $table.done, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TodoItemModelTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TodoItemModelTable,
          TodoItemModelData,
          $$TodoItemModelTableFilterComposer,
          $$TodoItemModelTableOrderingComposer,
          $$TodoItemModelTableAnnotationComposer,
          $$TodoItemModelTableCreateCompanionBuilder,
          $$TodoItemModelTableUpdateCompanionBuilder,
          (
            TodoItemModelData,
            BaseReferences<
              _$AppDatabase,
              $TodoItemModelTable,
              TodoItemModelData
            >,
          ),
          TodoItemModelData,
          PrefetchHooks Function()
        > {
  $$TodoItemModelTableTableManager(_$AppDatabase db, $TodoItemModelTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$TodoItemModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$TodoItemModelTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$TodoItemModelTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<bool> done = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
              }) => TodoItemModelCompanion(
                id: id,
                title: title,
                done: done,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<bool> done = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
              }) => TodoItemModelCompanion.insert(
                id: id,
                title: title,
                done: done,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TodoItemModelTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TodoItemModelTable,
      TodoItemModelData,
      $$TodoItemModelTableFilterComposer,
      $$TodoItemModelTableOrderingComposer,
      $$TodoItemModelTableAnnotationComposer,
      $$TodoItemModelTableCreateCompanionBuilder,
      $$TodoItemModelTableUpdateCompanionBuilder,
      (
        TodoItemModelData,
        BaseReferences<_$AppDatabase, $TodoItemModelTable, TodoItemModelData>,
      ),
      TodoItemModelData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TodoItemModelTableTableManager get todoItemModel =>
      $$TodoItemModelTableTableManager(_db, _db.todoItemModel);
}
