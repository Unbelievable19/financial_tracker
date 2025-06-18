import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
part 'database.g.dart';

class Transactions extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  BoolColumn get isIncome => boolean()();
  IntColumn get value => integer()();
  DateTimeColumn get date => dateTime()();
  IntColumn get category => integer().nullable().references(Categories, #id, onDelete: KeyAction.setNull)();
}

class Categories extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get color => text().withLength(min: 8, max: 8)();
}

@DriftDatabase(tables: [Transactions, Categories])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (migrator) async {
        await migrator.createAll();
        await batch((batch) async {
          batch.insertAll(categories, [
            CategoriesCompanion.insert(title: 'Питание', color: 'FF13CD9F'),
            CategoriesCompanion.insert(title: 'Развлечения', color: 'FFFDED39'),
            CategoriesCompanion.insert(title: 'Транспорт', color: 'FFB3E6FD'),
          ]);
        });
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}