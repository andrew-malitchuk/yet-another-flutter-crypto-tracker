import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../detalization_page.dart';

part 'detalization_navigation.g.dart';

@TypedGoRoute<DetalizationRoute>(
  path: '/detalization',
)
class DetalizationRoute extends GoRouteData {
  final String coin;

  const DetalizationRoute({required this.coin});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DetalizationPage(coin: coin);
  }
}