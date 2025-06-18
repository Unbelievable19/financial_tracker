import 'package:financial_tracker/core/data/db/database.dart';
import 'package:financial_tracker/core/domain/transaction_with_category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'states.freezed.dart';

abstract class TransactionState {}

class TransactionLoading implements TransactionState {}

@freezed
abstract class TransactionDraft
    with _$TransactionDraft
    implements TransactionState {
  const factory TransactionDraft({
    required String title,
    required bool isIncome,
    required DateTime date,
    Category? category,
    int? valueKopecks,
    int? id,
  }) = _TransactionDraft;

  factory TransactionDraft.fromTransaction(
    TransactionWithCategory transactionWithCategory,
  ) {
    final t = transactionWithCategory.transaction;
    final c = transactionWithCategory.category;
    return TransactionDraft(
      title: t.title,
      isIncome: t.isIncome,
      category: c,
      date: t.date,
      valueKopecks: t.value,
      id: t.id,
    );
  }
}

class TransactionError implements TransactionState {
  final Object error;

  TransactionError({required this.error});
}
