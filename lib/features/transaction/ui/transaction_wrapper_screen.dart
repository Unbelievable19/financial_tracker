import 'package:auto_route/auto_route.dart';
import 'package:financial_tracker/core/data/transactions_repository.dart';
import 'package:financial_tracker/features/transaction/domain/value_controller.dart';
import 'package:financial_tracker/features/transaction/ui/bloc/events.dart';
import 'package:financial_tracker/features/transaction/ui/bloc/transaction_bloc.dart';
import 'package:financial_tracker/features/transaction/ui/transaction_screen.dart';
import 'package:financial_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

@RoutePage()
class TransactionWrapperScreen extends StatelessWidget
    implements AutoRouteWrapper {
  final int? transactionId;
  final bool? isIncome;
  const TransactionWrapperScreen({
    super.key,
    @pathParam required this.transactionId,
    @pathParam required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    return TransactionScreen(isNewTransaction: transactionId == null);
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ValueController(),
      builder: (context, widget) {
        return BlocProvider<TransactionBloc>(
          create: (_) {
            final bloc = TransactionBloc(
              getIt.get<TransactionsRepository>(),
              transactionId,
            );
            if (isIncome != null) {
              bloc.add(TransactionTypeInitialized(createAsIncome: isIncome!));
            } else {
              bloc.add(TransactionFetched());
            }
            return bloc;
          },
          child: this,
        );
      },
    );
  }
}
