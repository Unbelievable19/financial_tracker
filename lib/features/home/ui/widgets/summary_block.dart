import 'package:financial_tracker/core/misc/extensions.dart';
import 'package:financial_tracker/features/home/ui/widgets/cashflow.dart';
import 'package:financial_tracker/features/home/ui/widgets/total_tile.dart';
import 'package:flutter/material.dart';

class SummaryBlock extends StatelessWidget {
  const SummaryBlock({
    super.key,
    required this.incomes,
    required this.expenses,
    required this.isLoaded,
  });

  factory SummaryBlock.loaded(int incomes, int expenses) {
    return SummaryBlock(incomes: incomes, expenses: expenses, isLoaded: true);
  }

  factory SummaryBlock.loading() {
    return SummaryBlock(incomes: 0, expenses: 0, isLoaded: false);
  }

  final int incomes;
  final int expenses;
  final bool isLoaded;

  int get cashflowKopecks => incomes - expenses;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TotalTile(
                label: "Доходы",
                icon: Icon(Icons.download),
                valueKopecks: incomes,
                gradient: context.colors.incomeGradient,
                isLoaded: isLoaded,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TotalTile(
                label: "Расходы",
                icon: Icon(Icons.upload, color: Colors.black),
                valueKopecks: expenses,
                gradient: context.colors.expenseGradient,
                isLoaded: isLoaded,
                textColor: Colors.black,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 8),
          child: Cashflow(cashflowKopecks: cashflowKopecks),
        ),
      ],
    );
  }
}
