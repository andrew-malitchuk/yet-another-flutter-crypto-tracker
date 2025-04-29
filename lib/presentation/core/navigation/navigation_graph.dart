import 'package:go_router/go_router.dart';
import 'package:presentation_feature_account_settings/core/navigation/account_settings_navigation.dart';
import 'package:presentation_feature_detalization/core/navigation/detalization_navigation.dart';
import 'package:presentation_feature_main/core/navigation/home_navigation.dart';
import 'package:presentation_feature_splash/core/navigation/splash_navigation.dart';
import 'package:presentation_feature_user_details/core/navigation/user_details_navigation.dart';
import 'package:presentation_feature_user_profile/core/navigation/user_profile_navigation.dart';
import 'package:presentation_feature_welcome/core/navigation/welcome_navigation.dart';

// final navigationGraph = GoRouter(
//   initialLocation: SplashRoute().location, // location getter is generated.
//   //$appRoutes is generated
//   routes: $appRoutes,
// );

final navigationGraph = GoRouter(
    initialLocation: SplashRoute().location, // location getter is generated.
    //$appRoutes is generated
    routes: [
      $homeShellRoute,
      $splashRoute,
      $userDetailsRoute,
      $welcomeRoute,
      $detalizationRoute,
      $userProfileRoute,
      $accountSettingsRoute
    ]);
