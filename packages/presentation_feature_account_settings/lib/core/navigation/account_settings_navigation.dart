import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../account_settings_page.dart';


part 'account_settings_navigation.g.dart';

@TypedGoRoute<AccountSettingsRoute>(
  path: '/account_settings',
)
class AccountSettingsRoute extends GoRouteData {
  const AccountSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AccountSettingsPage();
  }
}
