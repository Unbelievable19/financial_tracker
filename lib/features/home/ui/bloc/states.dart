import 'package:financial_tracker/core/domain/transaction_with_category.dart';
import 'package:financial_tracker/features/home/domain/calculator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'states.freezed.dart';

abstract class HomeState {}

class HomeLoading implements HomeState {}

@freezed
abstract class HomeLoaded with _$HomeLoaded implements HomeState {
  factory HomeLoaded({
    required List<TransactionWithCategory> transactionsWithCategory,
  }) = _HomeLoaded;

  HomeLoaded._();
  // ignore: annotate_overrides
  late final calculator = Calculator(transactions: transactionsWithCategory);

  int get totalIncomes => calculator.sum(TransactionType.incomes);
  int get totalExpenses => calculator.sum(TransactionType.expenses);
}

class HomeError implements HomeState {
  final Object error;

  HomeError({required this.error});
}
