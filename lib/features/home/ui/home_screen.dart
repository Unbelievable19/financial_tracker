import 'package:financial_tracker/core/data/transactions_repository.dart';
import 'package:financial_tracker/features/home/ui/bloc/home_bloc.dart';
import 'package:financial_tracker/features/home/ui/bloc/states.dart';
import 'package:financial_tracker/features/home/ui/widgets/summary_block.dart';
import 'package:financial_tracker/features/home/ui/widgets/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Финансовый Трекер")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is! HomeLoaded) return SummaryBlock.loading();
                  return SummaryBlock.loaded(
                    state.totalIncomes,
                    state.totalExpenses,
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Divider(height: 20, thickness: 2, indent: 8, endIndent: 8),
            ),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is! HomeLoaded) return SliverToBoxAdapter();
                return TransactionsList(
                  transactionsWithCategory: state.transactionsWithCategory,
                  calculator: state.calculator,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class StatisticBlock extends StatelessWidget {
  const StatisticBlock(TransactionsRepository transactionsRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
