
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/navigation/navigation_graph.dart';

class YafctApp extends StatelessWidget {
  const YafctApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: navigationGraph,
    );
  }
}
