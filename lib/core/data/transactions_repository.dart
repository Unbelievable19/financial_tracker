import 'package:drift/drift.dart';
import 'package:financial_tracker/core/data/db/database.dart';
import 'package:financial_tracker/core/domain/transaction_with_category.dart';

abstract class TransactionsRepository {
  Stream<List<TransactionWithCategory>> transactionsWithCategory();

  Future<TransactionWithCategory> getTransactionWithCategory(int id);

  Future<Transaction> addTransaction({
    required String title,
    required bool isIncome,
    required int value,
    required DateTime? date,
    int? categoryId,
  });

  Future<Transaction> updateTransaction({
    required int id,
    String? title,
    bool? isIncome,
    int? value,
    DateTime? date,
    required int? Function()? categoryIdSetter,
  });

  Future<void> removeTransaction(int id);
}

class TransactionsRepositoryImpl implements TransactionsRepository {
  final AppDatabase _db;

  TransactionsRepositoryImpl(this._db);

  @override
  Stream<List<TransactionWithCategory>> transactionsWithCategory() {
    final query = _db.select(_db.transactions).join([
      leftOuterJoin(
        _db.categories,
        _db.categories.id.equalsExp(_db.transactions.category),
      ),
    ]);
    return query.watch().map((rows) {
      return rows.map((row) {
        return TransactionWithCategory(
          transaction: row.readTable(_db.transactions),
          category: row.readTableOrNull(_db.categories),
        );
      }).toList();
    });
  }

  @override
  Future<TransactionWithCategory> getTransactionWithCategory(int id) async {
    final query = (_db.select(_db.transactions)
      ..where((t) => t.id.equals(id))).join([
      leftOuterJoin(
        _db.categories,
        _db.categories.id.equalsExp(_db.transactions.category),
      ),
    ]);
    final result = await (query..limit(1)).getSingleOrNull();
    if (result == null) throw Exception();
    return TransactionWithCategory(
      transaction: result.readTable(_db.transactions),
      category: result.readTableOrNull(_db.categories),
    );
  }

  @override
  Future<Transaction> addTransaction({
    required String title,
    required bool isIncome,
    required int value,
    required DateTime? date,
    int? categoryId,
  }) {
    return _db
        .into(_db.transactions)
        .insertReturning(
          TransactionsCompanion.insert(
            title: title,
            isIncome: isIncome,
            value: value,
            date: date ?? DateTime.now(),
            category: Value(categoryId),
          ),
        );
  }

  @override
  Future<Transaction> updateTransaction({
    required int id,
    String? title,
    bool? isIncome,
    int? value,
    DateTime? date,
    required int? Function()? categoryIdSetter,
  }) async {
    final returns = await (_db.update(_db.transactions)
      ..where((t) => t.id.equals(id))).writeReturning(
      TransactionsCompanion(
        id: Value(id),
        title: Value.absentIfNull(title),
        isIncome: Value.absentIfNull(isIncome),
        value: Value.absentIfNull(value),
        date: Value.absentIfNull(date),
        category:
            categoryIdSetter != null
                ? Value(categoryIdSetter())
                : Value.absent(),
      ),
    );
    if (returns.isEmpty) throw Exception();
    return returns.single;
  }

  @override
  Future<void> removeTransaction(int id) async {
    await (_db.delete(_db.transactions)..where((t) => t.id.equals(id))).go();
  }
}
