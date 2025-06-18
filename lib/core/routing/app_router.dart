import 'package:auto_route/auto_route.dart';
import 'package:financial_tracker/core/routing/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: RootRoute.page,
      initial: true,
      children: [
        AutoRoute(page: HomeWrapperRoute.page),
        AutoRoute(page: StatisticsWrapperRoute.page),
      ],
    ),
    AutoRoute(page: TransactionWrapperRoute.page),
  ];
}
