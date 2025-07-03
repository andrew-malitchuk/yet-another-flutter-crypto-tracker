import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../user_profile_page.dart';

part 'user_profile_navigation.g.dart';

@TypedGoRoute<UserProfileRoute>(
  path: '/user_profile',
)
class UserProfileRoute extends GoRouteData {
  const UserProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UserProfilePage();
  }
}
