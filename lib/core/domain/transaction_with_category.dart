import 'package:financial_tracker/core/data/db/database.dart';

class TransactionWithCategory {
  final Transaction transaction;
  final Category? category;

  TransactionWithCategory({required this.transaction, required this.category});
}
