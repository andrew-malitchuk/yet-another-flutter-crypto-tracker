import 'package:flutter/material.dart';

/// A scaffold that wraps the body in a `SafeArea` widget to avoid system UI overlaps.
class SafeScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;

  const SafeScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: appBar,
          body: body,
          bottomNavigationBar: bottomNavigationBar,
        ),
      ),
    );
  }
}
