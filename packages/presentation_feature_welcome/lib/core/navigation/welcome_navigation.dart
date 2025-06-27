import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../welcome_page.dart';

part 'welcome_navigation.g.dart';


@TypedGoRoute<WelcomeRoute>(
  path: '/welcome',
)
class WelcomeRoute extends GoRouteData {
  const WelcomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const WelcomePage();
  }
}