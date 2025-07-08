import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../user_details_page.dart';

part 'user_details_navigation.g.dart';


@TypedGoRoute<UserDetailsRoute>(
  path: '/user/details',
)
class UserDetailsRoute extends GoRouteData {
  const UserDetailsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UserDetailsPage();
  }
}