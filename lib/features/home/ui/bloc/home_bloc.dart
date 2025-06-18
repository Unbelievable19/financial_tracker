import 'package:financial_tracker/core/data/categories_repository.dart';
import 'package:financial_tracker/core/data/transactions_repository.dart';
import 'package:financial_tracker/features/home/domain/transactions_categories_bundle.dart';
import 'package:financial_tracker/features/home/ui/bloc/events.dart';
import 'package:financial_tracker/features/home/ui/bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TransactionsRepository _transactionsRepo;
  final CategoriesRepository _categoriesRepo;
  HomeBloc(this._transactionsRepo, this._categoriesRepo)
    : super(HomeLoading()) {
    on<HomeTransactionsSubscribed>(_onHomeTransactionSubscribed);
  }

  Future<void> _onHomeTransactionSubscribed(event, Emitter emit) {
    final transactionStream = _transactionsRepo.transactionsWithCategory();
    final categoriesStream = _categoriesRepo.categories();
    final combinedStream = Rx.combineLatest2(
      transactionStream,
      categoriesStream,
      (transactions, categories) => TransactionsCategoriesBundle(
        transactions: transactions,
        categories: categories,
      ),
    );
    return emit.forEach(
      combinedStream,
      onData:
          (bundle) => HomeLoaded(transactionsWithCategory: bundle.transactions),
    );
  }
}
