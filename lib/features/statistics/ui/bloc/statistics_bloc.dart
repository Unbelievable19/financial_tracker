import 'package:financial_tracker/core/data/categories_repository.dart';
import 'package:financial_tracker/core/data/transactions_repository.dart';
import 'package:financial_tracker/features/home/domain/transactions_categories_bundle.dart';
import 'package:financial_tracker/features/statistics/ui/bloc/events.dart';
import 'package:financial_tracker/features/statistics/ui/bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final TransactionsRepository _transactionsRepository;
  final CategoriesRepository _categoriesRepository;
  StatisticsBloc(this._transactionsRepository, this._categoriesRepository)
    : super(StatisticsLoading()) {
    on<StatisticsSubscribed>(_onStatisticsSubscribed);
  }

  Future<void> _onStatisticsSubscribed(event, Emitter emit) {
    final transactionStream =
        _transactionsRepository.transactionsWithCategory();
    final categoriesStream = _categoriesRepository.categories();
    final combinedStream = Rx.combineLatest2(
      transactionStream,
      categoriesStream,
      (ts, cs) =>
          TransactionsCategoriesBundle(transactions: ts, categories: cs),
    );

    return emit.forEach(
      combinedStream,
      onData: (bundle) {
        return StatisticsLoaded(
          transactions: bundle.transactions,
          categories: bundle.categories,
        );
      },
      onError: (error, stackTrace) {
        return StatisticsError("Ошибка: $error");
      },
    );
  }
}
