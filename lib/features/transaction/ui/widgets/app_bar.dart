import 'package:auto_route/auto_route.dart';
import 'package:financial_tracker/core/misc/extensions.dart';
import 'package:financial_tracker/core/widgets/close_button.dart';
import 'package:financial_tracker/features/transaction/ui/bloc/events.dart';
import 'package:financial_tracker/features/transaction/ui/bloc/states.dart';
import 'package:financial_tracker/features/transaction/ui/bloc/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TransactionAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          CloseBackButton(onTap: () => context.router.pop()),
          Spacer(),
          TransactionTypeSelector(),
          DeleteTransactionButtonConditional(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}

class TransactionTypeSelector extends StatelessWidget {
  const TransactionTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        final bloc = context.read<TransactionBloc>();
        if (state is TransactionLoading) {
          return SizedBox.shrink();
        } else if (state is TransactionDraft) {
          final isIncome = state.isIncome;
          toggleFunction() => bloc.add(TransactionTypeToggled());
          return isIncome
              ? TransactionTypeButton(
                icon: Icon(Icons.download),
                title: "Доход",
                onTap: toggleFunction,
              )
              : TransactionTypeButton(
                icon: Icon(Icons.upload),
                title: "Расход",
                onTap: toggleFunction,
              );
        }
        return SizedBox.shrink();
      },
    );
  }
}

class TransactionTypeButton extends StatelessWidget {
  const TransactionTypeButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final Icon icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: context.colors.border),
        borderRadius: BorderRadius.circular(100),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () => onTap(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: SizedBox(
            width: 90,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon,
                  SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 6),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DeleteTransactionButtonConditional extends StatelessWidget {
  const DeleteTransactionButtonConditional({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionDraft) {
          return Padding(
            padding: const EdgeInsets.only(left: 8),
            child: DeleteTransactionButton(
              onTap: () {
                context.read<TransactionBloc>().add(
                  TransactionDeleted(
                    onDeleted: () {
                      if (!context.mounted) return;
                      context.router.pop();
                    },
                  ),
                );
              },
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}

class DeleteTransactionButton extends StatelessWidget {
  const DeleteTransactionButton({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: context.colors.border),
        gradient: context.colors.deleteGradient,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.delete_outline),
        ),
      ),
    );
  }
}
