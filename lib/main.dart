import 'package:data_database/di/data_database_provider.dart';
import 'package:data_network/di/data_network_provider.dart';
import 'package:data_preference/core/initializer/hive_initilizer.dart';
import 'package:data_repository/di/data_repository_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:presentation_feature_account_settings/di/presentation_feature_account_settings.dart';
import 'package:presentation_feature_detalization/di/presentation_feature_detalization.dart';
import 'package:presentation_feature_main/market/di/presentation_feature_main_market.dart';
import 'package:presentation_feature_user_details/di/presentation_feature_user_details.dart';
import 'package:presentation_feature_user_profile/di/presentation_feature_user_profile.dart';
import 'package:provider/provider.dart';
import 'package:yafct/presentation/feature/app/yafct_app.dart';

import 'common/setup/env_setup.dart';

void main() async {
  setupEnv();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final providers = await preference_inirializer();

  final allProviders = [
    ...providers,
    ...dataDatabaseProviders,
    ...dataNetworkProviders,
    ...dataRepositoryProviders,
    ...presentationFeatureMainMarket,
    ...presentationFeatureDetalization,
    ...presentationFeatureUserDetails,
    ...presentationFeatureUserProfile,
    ...presentationFeatureAccountSettings,
  ];

  runApp(MultiProvider(
      providers: allProviders,
      child: EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('uk')],
          path: 'assets/translation',
          fallbackLocale: Locale('en'),
          saveLocale: true,
          child: YafctApp())));
}
