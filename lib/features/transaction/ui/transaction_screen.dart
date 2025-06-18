import 'package:auto_route/auto_route.dart';
import 'package:financial_tracker/core/data/categories_repository.dart';
import 'package:financial_tracker/core/data/db/database.dart';
import 'package:financial_tracker/core/misc/extensions.dart';
import 'package:financial_tracker/core/widgets/custom_cupertino_button.dart';
import 'package:financial_tracker/features/category/ui/bloc/category_selector_bloc.dart';
import 'package:financial_tracker/features/category/ui/bloc/events.dart';
import 'package:financial_tracker/features/category/ui/category_button.dart';
import 'package:financial_tracker/features/category/ui/category_selector_bottom_sheet.dart';
import 'package:financial_tracker/features/transaction/domain/value_controller.dart';
import 'package:financial_tracker/features/transaction/ui/bloc/events.dart';
import 'package:financial_tracker/features/transaction/ui/bloc/states.dart';
import 'package:financial_tracker/features/transaction/ui/bloc/transaction_bloc.dart';
import 'package:financial_tracker/features/transaction/ui/widgets/app_bar.dart';
import 'package:financial_tracker/features/transaction/ui/widgets/date_picker.dart';
import 'package:financial_tracker/features/transaction/ui/widgets/value_%20bottom_sheet.dart';
import 'package:financial_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key, required this.isNewTransaction});
  final bool isNewTransaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TransactionAppBar(),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is TransactionError) return Center(child: Text("Ошибка"));

          if (state is TransactionDraft) {
            return TransactionFormScreen(
              state: state,
              isNewTransaction: isNewTransaction,
            );
          }
          throw Exception();
        },
      ),
    );
  }
}

class TransactionFormScreen extends StatefulWidget {
  final TransactionDraft state;
  final bool isNewTransaction;
  const TransactionFormScreen({
    super.key,
    required this.state,
    required this.isNewTransaction,
  });

  @override
  State<TransactionFormScreen> createState() => _TransactionFormScreenState();
}

class _TransactionFormScreenState extends State<TransactionFormScreen> {
  late final TextEditingController titleController;

  bool didShowValueSheet = false;
  bool didShowCategorySheet = false;
  final titleFocusNode = FocusNode();

  TransactionDraft get state => widget.state;

  Future<void> _showValueSheet() {
    final completed = showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<TransactionBloc>(),
          child: ChangeNotifierProvider.value(
            value: context.read<ValueController>(),
            builder: (context, widget) {
              return ValueBottomSheet();
            },
          ),
        );
      },
    );
    return completed;
  }

  void _showCategorySheet(BuildContext context, Category? category) {
    final selectedEvent = showModalBottomSheet<CategorySelected?>(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<TransactionBloc>()),
            BlocProvider<CategorySelectorBloc>(
              create: (context) {
                return CategorySelectorBloc(getIt.get<CategoriesRepository>())
                  ..add(SubscribedToCategories(category));
              },
            ),
          ],
          child: CategorySelectorBottomSheet(),
        );
      },
    );
    selectedEvent.then((event) {
      if (!context.mounted) return;
      if (event == null) return;
      context.read<TransactionBloc>().add(
        TransactionCategorySet(category: event.selected),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: state.title);
    didShowValueSheet = !widget.isNewTransaction;
    didShowCategorySheet = !widget.isNewTransaction;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller = context.read<ValueController>();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => controller.setInitialValue(state.valueKopecks ?? 0),
    );
    if (!didShowValueSheet) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final completed = _showValueSheet();
        didShowValueSheet = true;
        completed.then((_) {
          if (didShowCategorySheet) return;
          if (context.mounted) {
            // ignore: use_build_context_synchronously
            _showCategorySheet(context, state.category);
            didShowCategorySheet = true;
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: titleController,
            focusNode: titleFocusNode,
            decoration: _getInputDecoration(),
            style: TextStyle(fontSize: 28),
            cursorColor: context.colors.cursorColor,
            autocorrect: false,
            textCapitalization: TextCapitalization.sentences,
            maxLength: 120,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            onTapOutside: (_) => titleFocusNode.unfocus(),
          ),
          SizedBox(height: 12),
          CategorySelectorButton(
            category: state.category,
            onTap: () => _showCategorySheet(context, state.category),
          ),
          SizedBox(height: 16),
          DatePicker(date: state.date),
          SizedBox(height: context.sizeScreen.height * 0.25),
          ValueWidget(
            onTap: () {
              _showValueSheet();
            },
          ),
          Spacer(),
          SafeArea(
            child: Center(
              child: CustomCupertinoButton(
                onTap: () {
                  final valueKopecks = context.read<ValueController>().value;
                  if (_maybeShowZeroSumWarningSnackbar(context, valueKopecks)) {
                    return;
                  }
                  final bloc = context.read<TransactionBloc>();
                  bloc.add(
                    TransactionSaved(
                      title: titleController.text,
                      valueKopecks: valueKopecks,
                    ),
                  );
                  context.router.pop();
                },
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  bool _maybeShowZeroSumWarningSnackbar(BuildContext context, int value) {
    if (value == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: context.theme.canvasColor,
          duration: Duration(seconds: 1),
          content: Text(
            'Укажите сумму больше 0',
            style: TextStyle(
              color: context.colors.contrast,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
      return true;
    }
    return false;
  }

  InputDecoration _getInputDecoration() {
    final border = UnderlineInputBorder(
      borderSide: BorderSide(color: context.colors.border, width: 2),
    );
    return InputDecoration(
      border: border,
      enabledBorder: border,
      focusedBorder: border,
      errorBorder: border,
      focusedErrorBorder: border,
      hintText: "Название",
      hintStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      counterText: "",
    );
  }
}
