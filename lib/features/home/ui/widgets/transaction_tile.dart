import 'package:auto_route/auto_route.dart';
import 'package:financial_tracker/core/data/db/database.dart';
import 'package:financial_tracker/core/domain/transaction_with_category.dart';
import 'package:financial_tracker/core/misc/extensions.dart';
import 'package:financial_tracker/core/misc/utils.dart';
import 'package:financial_tracker/core/routing/app_router.gr.dart';
import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final TransactionWithCategory transactionWithCategory;

  const TransactionTile({super.key, required this.transactionWithCategory});

  Transaction get transaction => transactionWithCategory.transaction;
  Category? get category => transactionWithCategory.category;

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap:() => context.router.push(TransactionWrapperRoute(transactionId: transaction.id, isIncome: null)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (category != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CategoryChip(category: category!),
                  ),
                if (transaction.title.isNotEmpty)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          transaction.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                if (transaction.title.isNotEmpty) SizedBox(height: 12),
                PriceRow(
                  valueKopecks: transaction.value,
                  isIncome: transaction.isIncome,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final Category category;
  const CategoryChip({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: category.flutterColor,
      ),
      child: Text(
        category.title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: category.flutterColor.maybeInvertedTextColor(
            Colors.white,
            Colors.black,
          ),
        ),
      ),
    );
  }
}

class PriceRow extends StatelessWidget {
  final int valueKopecks;
  final bool isIncome;
  const PriceRow({
    super.key,
    required this.valueKopecks,
    required this.isIncome,
  });

  String get valueFormatted =>
      AppFormatters.formatRublesWithSeparatorsAndDecimalPart(
        valueKopecks / 100,
        decimalDigits: 2,
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient:
                isIncome
                    ? context.colors.incomeGradient
                    : context.colors.expenseGradient,
          ),
          child:
              isIncome ? const Icon(Icons.download) : const Icon(Icons.upload),
        ),
        SizedBox(width: 8),
        Text(
          valueFormatted,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color:
                isIncome
                    ? context.colors.incomeGradient.colors.first
                    : context.colors.expenseGradient.colors.first,
          ),
        ),
      ],
    );
  }
}
