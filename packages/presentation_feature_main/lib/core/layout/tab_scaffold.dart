import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../navigation/home_navigation.dart';

class TabScaffold extends StatelessWidget {
  final Widget child;

  const TabScaffold({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: location.startsWith('/portfolio') ? 1 : 0,
        onTap: (index) {
          if (index == 0) {
            const MarketRoute().go(context);
          } else {
            const PortfolioRoute().go(context);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Portfolio',
          ),
        ],
      ),
    );
  }
}
