import 'package:financial_tracker/core/misc/extensions.dart';
import 'package:financial_tracker/core/misc/utils.dart';
import 'package:flutter/material.dart';

class Cashflow extends StatelessWidget {
  const Cashflow({super.key, required this.cashflowKopecks});
  final int cashflowKopecks;

  String get cashflow{
    return AppFormatters.convertKopecsToRublesAndFormat(cashflowKopecks);
  }

  @override
  Widget build(BuildContext context) {
    return Text("Разница: $cashflow", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: context.colors.secondaryText),);
  }
}