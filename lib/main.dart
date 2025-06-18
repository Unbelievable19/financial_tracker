import 'package:financial_tracker/core/data/categories_repository.dart';
import 'package:financial_tracker/core/data/db/database.dart';
import 'package:financial_tracker/core/data/transactions_repository.dart';
import 'package:financial_tracker/core/routing/app_router.dart';
import 'package:financial_tracker/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

final getIt = GetIt.instance;
final _appRouter = AppRouter();
void main() {
  getIt.registerSingleton<AppDatabase>(AppDatabase());
  getIt.registerLazySingleton<TransactionsRepository>(
    () => TransactionsRepositoryImpl(getIt.get<AppDatabase>()),
  );
  getIt.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(getIt.get<AppDatabase>()),
  );
  // getIt.get<TransactionsRepository>().addTransaction(
  //   title: "Зарплата",
  //   isIncome: true,
  //   value: 1080000,
  //   categoryId: 1,
  //   date: DateTime.now(),
  // );

  initializeDateFormatting('ru_RU');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.nightTheme,
      routerConfig: _appRouter.config(),
    );
  }
}
