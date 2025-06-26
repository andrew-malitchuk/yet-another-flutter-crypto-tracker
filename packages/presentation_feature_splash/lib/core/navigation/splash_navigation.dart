import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../splash_page.dart';

part 'splash_navigation.g.dart';

@TypedGoRoute<SplashRoute>(
  path: '/splash',
)
class SplashRoute extends GoRouteData {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashPage();
  }
}
