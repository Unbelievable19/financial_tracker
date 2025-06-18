import 'package:financial_tracker/core/domain/transaction_with_category.dart';
import 'package:financial_tracker/core/misc/extensions.dart';
import 'package:financial_tracker/core/misc/utils.dart';
import 'package:financial_tracker/features/home/domain/calculator.dart';
import 'package:financial_tracker/features/home/ui/widgets/date_header.dart';
import 'package:financial_tracker/features/home/ui/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/sliver_grouped_list.dart';

class TransactionsList extends StatelessWidget {
  final List<TransactionWithCategory> transactionsWithCategory;
  final Calculator calculator;
  const TransactionsList({
    super.key,
    required this.transactionsWithCategory,
    required this.calculator,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGroupedListView(
      elements: transactionsWithCategory,
      groupBy:
          (TransactionWithCategory element) =>
              element.transaction.date.roundToDayStart,

      order: GroupedListOrder.DESC,
      itemComparator: (t1, t2) {
        final date1 = t1.transaction.date;
        final date2 = t2.transaction.date;
        return date1.compareTo(date2);
      },
      itemBuilder: (context, item) {
        return TransactionTile(transactionWithCategory: item);
      },
      separator: SizedBox(height: 12),
      groupHeaderBuilder: (item) {
        final cashflowForDay = calculator.cashflowForDay(item.transaction.date);
        String cashflowFormatted =
            AppFormatters.formatRublesWithSeparatorsAndDecimalPart(
              (cashflowForDay / 100).abs(),
              decimalDigits: 2,
            );
        return DateHeader(
          date: item.transaction.date,
          cashflow: cashflowFormatted,
          isIncome: cashflowForDay >= 0,
        );
      },
    );
  }
}
