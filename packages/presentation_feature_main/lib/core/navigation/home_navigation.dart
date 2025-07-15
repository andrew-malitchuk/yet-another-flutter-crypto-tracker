import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../add_new_coin/add_new_coin_page.dart';
import '../../home_page.dart';
import '../../market/market_page.dart';
import '../../portfolio/portfolio_page.dart';

part 'home_navigation.g.dart';

@TypedShellRoute<HomeShellRoute>(
  routes: [
    TypedGoRoute<MarketRoute>(
      path: '/home/market',
    ),
    TypedGoRoute<AddNewCoinRoute>(
      path: '/home/coin',
    ),
    TypedGoRoute<PortfolioRoute>(
      path: '/home/portfolio',
    ),
  ],
)
class HomeShellRoute extends ShellRouteData {
  const HomeShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget child) {
    return HomePage(child: child); // Scaffold with tabs
  }
}

class MarketRoute extends GoRouteData {
  const MarketRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const MarketPage();
}

class PortfolioRoute extends GoRouteData {
  const PortfolioRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PortfolioPage();
}

class AddNewCoinRoute extends GoRouteData {
  const AddNewCoinRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const AddNewCoinPage();
}