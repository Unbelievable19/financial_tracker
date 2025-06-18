import 'package:auto_route/auto_route.dart';
import 'package:financial_tracker/core/data/categories_repository.dart';
import 'package:financial_tracker/core/data/transactions_repository.dart';
import 'package:financial_tracker/features/home/ui/home_screen.dart';
import 'package:financial_tracker/features/statistics/ui/bloc/events.dart';
import 'package:financial_tracker/features/statistics/ui/bloc/statistics_bloc.dart';
import 'package:financial_tracker/features/statistics/ui/statistics_screen.dart';
import 'package:financial_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class StatisticsWrapperScreen extends StatelessWidget
    implements AutoRouteWrapper {
  const StatisticsWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StatisticsScreen();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create:
          (context) => StatisticsBloc(
            getIt.get<TransactionsRepository>(),
            getIt.get<CategoriesRepository>(),
          )..add(StatisticsSubscribed()),
      child: this,
    );
  }
}
