import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:financial_tracker/core/misc/extensions.dart';
import 'package:financial_tracker/core/widgets/close_button.dart';
import 'package:financial_tracker/core/widgets/confirm_button.dart';
import 'package:financial_tracker/features/transaction/domain/value_controller.dart';
import 'package:financial_tracker/features/transaction/ui/bloc/states.dart';
import 'package:financial_tracker/features/transaction/ui/bloc/transaction_bloc.dart';
import 'package:financial_tracker/features/transaction/ui/widgets/bottom_actions.dart';
import 'package:financial_tracker/features/transaction/ui/widgets/value_numpad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ValueBottomSheet extends StatelessWidget {
  const ValueBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 24),
          Text(
            "Сумма",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
          ),
          ValueWidget(onTap: () {}),
          SizedBox(height: 32),
          Center(
            child: ValueNumpad(
              onTap: (key) {
                final controller = context.read<ValueController>();
                controller.onKeyTap(key);
              },
            ),
          ),
          SizedBox(height: 32),
          BottomActions(
            closeButton: CloseBackButton.forBottomActions(
              onTap: () => context.router.pop(),
            ),
            actionButton: LongButton.confirm(
              gradient: context.colors.incomeGradient,
              onTap: () => context.router.pop(),
            ),
          ),
        ],
      ),
    );
  }
}

class ValueWidget extends StatelessWidget {
  const ValueWidget({super.key, this.onTap});

  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoading || state is TransactionError) {
          return const SizedBox.shrink();
        }
        if (state is TransactionDraft) {
          return Center(
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(24),
              child: SizedBox(
                width: context.sizeScreen.width * 0.7,
                height: 80,
                child: Center(
                  child: Consumer<ValueController>(
                    builder: (context, controller, widget) {
                      final formatted = controller.formatted;
                      return AutoSizeText(
                        formatted,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        minFontSize: 9,
                        maxFontSize: 36,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        }
        throw UnimplementedError();
      },
    );
  }
}
