import 'package:financial_tracker/core/data/db/database.dart';
import 'package:flutter/material.dart';

abstract class TransactionEvent {}

class TransactionFetched implements TransactionEvent {}

class TransactionTypeToggled implements TransactionEvent {}

class TransactionCategorySet implements TransactionEvent {
  final Category? category;

  TransactionCategorySet({required this.category});
}

class TransactionTypeInitialized implements TransactionEvent {
  final bool createAsIncome;

  TransactionTypeInitialized({required this.createAsIncome});
}

class TransactionDateSet implements TransactionEvent {
  final DateTime date;

  TransactionDateSet(this.date);
}

class TransactionSaved implements TransactionEvent {
  final String title;
  final int valueKopecks;

  TransactionSaved({required this.title, required this.valueKopecks});
}

class TransactionDeleted implements TransactionEvent {
  final VoidCallback onDeleted;

  TransactionDeleted({required this.onDeleted});
}
