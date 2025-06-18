import 'package:auto_route/auto_route.dart';
import 'package:financial_tracker/core/data/db/database.dart';
import 'package:financial_tracker/core/misc/extensions.dart';
import 'package:financial_tracker/core/widgets/close_button.dart';
import 'package:financial_tracker/core/widgets/confirm_button.dart';
import 'package:financial_tracker/features/category/ui/bloc/category_selector_bloc.dart';
import 'package:financial_tracker/features/category/ui/bloc/events.dart';
import 'package:financial_tracker/features/category/ui/bloc/states.dart';
import 'package:financial_tracker/features/category/ui/category_button.dart';
import 'package:financial_tracker/features/category/ui/create_category_bottom_sheet.dart';
import 'package:financial_tracker/features/transaction/ui/widgets/bottom_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorySelectorBottomSheet extends StatelessWidget {
  const CategorySelectorBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Выберите категорию",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: context.sizeScreen.height * 0.7,
                ),
                child: SingleChildScrollView(child: CategoriesWrappedList()),
              ),
              SizedBox(height: 12),
              BottomActions(
                closeButton: CloseBackButton.forBottomActions(
                  onTap: context.router.pop,
                ),
                actionButton: LongButton.skip(
                  onTap: () => context.router.pop(),
                  borderColor: context.colors.border,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class CategoriesWrappedList extends StatelessWidget {
  const CategoriesWrappedList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategorySelectorBloc, CategorySelectorState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is CategoriesLoading) return const SizedBox.shrink();
        if (state is CategoriesError) {
          return Center(child: Text(state.reason));
        }
        if (state is CategoriesLoaded) {
          return Builder(
            builder: (context) {
              bool isSelected(Category c) => c.id == state.selected?.id;
              final bloc = context.read<CategorySelectorBloc>();
              final categoriesChips =
                  state.categories.map<Widget>((category) {
                    if (isSelected(category)) {
                      return CategoryItemButton.selected(
                        category: category,
                        onTap: () {
                          bloc.add(CategorySelected(category));
                          context.router.pop(CategorySelected(category));
                        },
                        onDeselect: () {
                          bloc.add(CategorySelected(null));
                          context.router.pop(CategorySelected(null));
                        },
                      );
                    } else {
                      return CategoryItemButton.unselected(
                        category: category,
                        onTap: () {
                          bloc.add(CategorySelected(category));
                          context.router.pop(CategorySelected(category));
                        },
                        context: context,
                      );
                    }
                  }).toList();
              categoriesChips.add(
                CreateCategoryButton(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (modalContext) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom:
                                MediaQuery.of(modalContext).viewInsets.bottom,
                          ),
                          child: SafeArea(
                            child: CreateCategoryBottomSheet(
                              onAdd: (title, color) {
                                final bloc =
                                    context.read<CategorySelectorBloc>();
                                bloc.add(
                                  CategoryCreated(title: title, color: color),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );

              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: categoriesChips.toList(),
              );
            },
          );
        }
        return Center();
      },
    );
  }
}
