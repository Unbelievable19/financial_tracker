import 'package:financial_tracker/core/data/db/database.dart';
import 'package:financial_tracker/core/domain/transaction_with_category.dart';
import 'package:financial_tracker/core/misc/extensions.dart';
import 'package:financial_tracker/features/home/domain/calculator.dart';
import 'package:financial_tracker/features/statistics/domain/chart_segment.dart';

abstract class StatisticsState {}

class StatisticsError implements StatisticsState {
  final String reason;

  StatisticsError(this.reason);
}

class StatisticsLoading implements StatisticsState {}

class StatisticsLoaded implements StatisticsState {
  final List<TransactionWithCategory> transactions;
  final List<Category> categories;

  StatisticsLoaded({required this.transactions, required this.categories});

  late final calc = Calculator(transactions: transactions);
  late final sumForIncomes = calc.sum(TransactionType.incomes);
  late final sumForExpenses = calc.sum(TransactionType.expenses);

  int sumForTransactionType(TransactionType type) {
    if (TransactionType.incomes == type) {
      return sumForIncomes;
    }
    return sumForExpenses;
  }

  List<ChartSegment> getChartSegments(TransactionType type) {
    final List<TransactionWithCategory> typedTransactions;

    if (TransactionType.incomes == type) {
      typedTransactions = calc.incomes;
    } else {
      typedTransactions = calc.expenses;
    }

    final List<ChartSegment> segments = [];
    for (final category in categories) {
      final tr = typedTransactions.where((t) => t.category?.id == category.id);
      final sum = tr.fold(0, (sum, t) => sum + t.transaction.value);
      segments.add(
        ChartSegment(
          categoryId: category.id,
          title: category.title,
          color: category.flutterColor,
          valueKopecks: sum,
        ),
      );
    }

    final transactionWithoutCategory =
        typedTransactions.where((t) => t.category == null).toList();

    final noCategorySum = transactionWithoutCategory.fold(
      0,
      (sum, t) => sum + t.transaction.value,
    );

    final noCategorySegment = ChartSegment(
      categoryId: null,
      title: "Без категории",
      color: null,
      valueKopecks: noCategorySum,
    );
    segments.add(noCategorySegment);

    return segments..sort((a, b) => b.valueKopecks.compareTo(a.valueKopecks));
  }
}
