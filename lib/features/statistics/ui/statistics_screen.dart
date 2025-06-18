import 'package:auto_size_text/auto_size_text.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:financial_tracker/core/misc/extensions.dart';
import 'package:financial_tracker/core/misc/utils.dart';
import 'package:financial_tracker/features/home/domain/calculator.dart';
import 'package:financial_tracker/features/statistics/ui/bloc/states.dart';
import 'package:financial_tracker/features/statistics/ui/bloc/statistics_bloc.dart';
import 'package:financial_tracker/features/statistics/ui/widgets/categories_total_list.dart';
import 'package:financial_tracker/features/statistics/ui/widgets/chart.dart';
import 'package:financial_tracker/features/statistics/ui/widgets/segmented_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final viewController = CustomSegmentedController<TransactionType>(
      value: TransactionType.incomes);
  TransactionType currentView = TransactionType.incomes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Статистика'),
        scrolledUnderElevation: 0,
        backgroundColor: context.theme.scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SegmentedPicker(
                controller: viewController,
                onValueChanged: (view) => setState(() {
                      currentView = view;
                    }),
                segments: [
                  PickerSegment(
                      enumerator: TransactionType.incomes, title: 'Доходы'),
                  PickerSegment(
                      enumerator: TransactionType.expenses, title: 'Расходы'),
                ]),
          ),
          BlocBuilder<StatisticsBloc, StatisticsState>(
            builder: (context, state) {
              if (state is StatisticsLoading) return const SizedBox.shrink();
              if (state is StatisticsError) {
                return Center(child: Text(state.reason));
              }
              if (state is StatisticsLoaded) {
                final valueKopecks = state.sumForTransactionType(currentView);
                final valueFormatted =
                    AppFormatters.formatRublesWithSeparatorsAndDecimalPart(
                        valueKopecks / 100,
                        decimalDigits: 2);
                if (valueKopecks == 0) {
                  return Expanded(child: NoDataPlaceholder());
                }
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16)
                        .copyWith(top: 12),
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Center(
                            child: AutoSizeText(
                              valueFormatted,
                              maxFontSize: 32,
                              minFontSize: 20,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(child: const SizedBox(height: 16)),
                        SliverToBoxAdapter(
                          child: Chart(
                              isIncome: TransactionType.incomes == currentView,
                              segments: state.getChartSegments(currentView),
                              totalValue:
                                  state.sumForTransactionType(currentView)),
                        ),
                        SliverToBoxAdapter(child: const SizedBox(height: 8)),
                        CategoriesTotalsList(transactionType: currentView),
                        SliverToBoxAdapter(child: const SizedBox(height: 16)),
                      ],
                    ),
                  ),
                );
              }
              throw UnimplementedError();
            },
          )
        ],
      ),
    );
  }
}

class NoDataPlaceholder extends StatelessWidget {
  const NoDataPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: SizedBox(
          width: context.sizeScreen.width * 0.7,
          child: Text(
            'Недостаточно данных для анализа. Добавьте транзакции.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: context.colors.secondaryText),
          ),
        ),
      ),
    );
  }
}