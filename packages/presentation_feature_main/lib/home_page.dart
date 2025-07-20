
import 'package:flutter/material.dart';

import 'home_view.dart';

class HomePage extends StatelessWidget {
  final Widget child;

  const HomePage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return HomeView(
      child: child,
    );
  }
}
