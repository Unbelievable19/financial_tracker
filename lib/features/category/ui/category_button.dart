import 'package:financial_tracker/core/data/db/database.dart';
import 'package:financial_tracker/core/misc/extensions.dart';
import 'package:flutter/material.dart';

class CategorySelectorButton extends StatelessWidget {
  const CategorySelectorButton({super.key, this.category, required this.onTap});
  final Category? category;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.all(6).copyWith(right: 16),
        decoration: BoxDecoration(
          color: category?.flutterColor,
          borderRadius: BorderRadius.circular(100),
          border:
              category == null
                  ? Border.all(color: context.colors.border)
                  : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: category != null ? Colors.white : context.colors.border,
              ),
              child: SizedBox(height: 28, width: 28),
            ),
            SizedBox(width: 8),
            Text(
              category?.title ?? "Добавить категорию",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: category?.flutterColor.maybeInvertedTextColor(
                  Colors.white,
                  Colors.black,
                ),
              ),
            ),
            SizedBox(width: 0),
            if (category == null)
              SizedBox(
                width: 12,
                child: Icon(Icons.chevron_right),
              ), // возможно стоит юзать паддинг
          ],
        ),
      ),
    );
  }
}

class CategoryItemButton extends StatelessWidget {
  const CategoryItemButton({
    super.key,
    required this.category,
    required this.onTap,
    required this.isSelected,
    required this.circleColor,
    required this.fillColor,
    required this.borderColor,
    this.onDeselect,
    required this.borderWidth,
    required this.circleSize,
    this.deselectBySeparateButton = true,
    this.selectableMode = false,
  });
  final Category? category;
  final Function onTap;
  final VoidCallback? onDeselect;
  final bool isSelected;
  final Color circleColor;
  final Color fillColor;
  final Color borderColor;
  final double borderWidth;
  final double circleSize;
  final bool selectableMode;
  final bool deselectBySeparateButton;

  factory CategoryItemButton.selected({
    required Category category,
    required Function onTap,
    required VoidCallback onDeselect,
  }) {
    return CategoryItemButton(
      category: category,
      onTap: onTap,
      onDeselect: onDeselect,
      isSelected: true,
      circleColor: Colors.white,
      fillColor: category.flutterColor,
      borderColor: Colors.white,
      borderWidth: 2,
      circleSize: 25.5,
    );
  }
  factory CategoryItemButton.unselected({
    required Category category,
    required Function onTap,
    required BuildContext context,
  }) {
    return CategoryItemButton(
      category: category,
      onTap: onTap,
      isSelected: false,
      circleColor: category.flutterColor,
      fillColor: Colors.transparent,
      borderColor: context.colors.border,
      borderWidth: 1,
      circleSize: 28,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.sizeScreen.width;
    final maxTextWidth = screenWidth - 120;
    final double side = circleSize;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: borderWidth),
        color: fillColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              if (!deselectBySeparateButton) {
                isSelected ? onDeselect?.call() : () => onTap();
                return;
              }
              onTap();
            },
            borderRadius: BorderRadius.circular(100),
            child: Padding(
              padding: const EdgeInsets.all(6).copyWith(right: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: circleColor,
                    ),
                    child: SizedBox(height: side, width: side),
                  ),
                  SizedBox(width: 8),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxTextWidth),
                    child: Text(
                      category?.title ?? 'Выбрать категорию',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: fillColor.maybeInvertedTextColor(
                          Colors.white,
                          Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isSelected) DeselectButton(onDeselect: onDeselect, side: side),
        ],
      ),
    );
  }
}

class DeselectButton extends StatelessWidget {
  const DeselectButton({
    super.key,
    required this.onDeselect,
    required this.side,
  });

  final VoidCallback? onDeselect;
  final double side;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 6,
      top: 6,
      bottom: 6,
      child: GestureDetector(
        onTap: () {
          onDeselect?.call();
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          child: SizedBox(
            height: side,
            width: side,
            child: Icon(Icons.remove, color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class CreateCategoryButton extends StatelessWidget {
  const CreateCategoryButton({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.categorySelectedBorder),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(100),
      ),
      child: InkWell(
        onTap: () => onTap(),
        borderRadius: BorderRadius.circular(100),
        child: Padding(
          padding: const EdgeInsets.all(8).copyWith(right: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add),
              SizedBox(),
              Text(
                "Добавить",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
