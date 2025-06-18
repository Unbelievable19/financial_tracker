import 'package:auto_route/auto_route.dart';
import 'package:financial_tracker/core/routing/app_router.gr.dart';
import 'package:financial_tracker/features/navigation/widgets/add_transaction_button.dart';
import 'package:financial_tracker/features/navigation/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  bool isMenuOpen = false;
  static const greyAlpha = 192;
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [HomeWrapperRoute(), StatisticsWrapperRoute()],
      bottomNavigationBuilder: (context, tabsRouter) {
        return Opacity(
          opacity: isMenuOpen ? (255 - greyAlpha) / 255 : 1,
          child: SafeArea(
            child: CustomBottomNavigationBar(
              tabsRouter: tabsRouter,
              height: 50,
            ),
          ),
        );
      },
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        alignment: Alignment.bottomCenter,
        //fit: StackFit.loose,
        children: [
          if (isMenuOpen)
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: Colors.black.withAlpha(greyAlpha),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isMenuOpen = false;
                    });
                  },
                ),
              ),
            ),
          AddTransactionButton(
            onToggle: (isOpen) {
              setState(() {
                isMenuOpen = isOpen;
              });
            },
            isOpen: isMenuOpen,
          ),
        ],
      ),
    );
  }
}
