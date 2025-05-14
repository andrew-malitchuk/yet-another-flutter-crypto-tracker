import 'package:data_preference/model/user_profile_prefernce_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../source/preference_source.dart';

// TODO rename this file to preference_initializer.dart
Future<List<SingleChildWidget>> initCoreDI() async {

  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(UserProfileAdapter());

  final userBox = await Hive.openBox<UserProfile>('user_profile_box');

  return [
    Provider<HiveInterface>.value(value: Hive),
    Provider<PreferenceSource>(create: (_) => PreferenceSource(userBox)),
  ];
}