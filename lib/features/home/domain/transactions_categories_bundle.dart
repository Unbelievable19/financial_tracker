import 'package:financial_tracker/core/data/db/database.dart';
import 'package:financial_tracker/core/domain/transaction_with_category.dart';

class TransactionsCategoriesBundle {

  final List<TransactionWithCategory> transactions;
  final List<Category> categories;

  TransactionsCategoriesBundle({required this.transactions, required this.categories});
}