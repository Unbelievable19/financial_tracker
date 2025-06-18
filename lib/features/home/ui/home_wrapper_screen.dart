import 'package:auto_route/auto_route.dart';
import 'package:financial_tracker/core/data/categories_repository.dart';
import 'package:financial_tracker/core/data/transactions_repository.dart';
import 'package:financial_tracker/features/home/ui/bloc/events.dart';
import 'package:financial_tracker/features/home/ui/bloc/home_bloc.dart';
import 'package:financial_tracker/features/home/ui/home_screen.dart';
import 'package:financial_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeWrapperScreen extends StatelessWidget implements AutoRouteWrapper {
  const HomeWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create:
          (context) => HomeBloc(
            getIt.get<TransactionsRepository>(),
            getIt.get<CategoriesRepository>(),
          )..add(HomeTransactionsSubscribed()),
          child: this,
    );
  }
}
