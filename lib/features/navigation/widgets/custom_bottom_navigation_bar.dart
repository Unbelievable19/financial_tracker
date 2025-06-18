import 'package:auto_route/auto_route.dart';
import 'package:financial_tracker/core/misc/extensions.dart';
import 'package:financial_tracker/features/navigation/widgets/custom_tab_button.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.tabsRouter,
    required this.height,
  });

  final TabsRouter tabsRouter;
  final double height;

  double get verticalButtonInset => height * 0.1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: context.theme.canvasColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TabButton(
              icon: Icon(Icons.home_filled),
              label: "Главная",
              onTap: () => tabsRouter.setActiveIndex(0),
              isSelected: tabsRouter.activeIndex == 0,
              verticalInset: verticalButtonInset,
            ),
            TabButton(
              icon: Icon(Icons.analytics_outlined),
              label: "Статистика",
              onTap: () => tabsRouter.setActiveIndex(1),
              isSelected: tabsRouter.activeIndex == 1,
              verticalInset: verticalButtonInset,
            ),
          ],
        ),
      ),
    );
  }
}

