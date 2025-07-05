import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';
import 'package:presentation_core_ui/layout/safe_scaffold.dart';
import 'package:presentation_core_ui/layout/scrollable_column.dart';
import 'package:presentation_core_ui/widget/header/header_divider_controller.dart';
import 'package:presentation_core_ui/widget/header/simple_header.dart';
import 'package:presentation_feature_account_settings/core/navigation/account_settings_navigation.dart';

import 'core/components/user_avatar.dart';
import 'core/components/user_profile_item.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

// TODO: wtf
class _UserProfileViewState extends State<UserProfileView> {
  final HeaderDividerController headerDividerController =
      HeaderDividerController();

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
        appBar: SimpleHeader(
          headerDividerController: headerDividerController,
          title: context.tr("userProfileTitle"),
          onPressed: () {
            context.pop();
          },
        ),
        body: _buildContent(context));
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ScrollableColumn(
          onOverScroll: (isOverScroll) {
            headerDividerController.setVisibility(isOverScroll);
          },
          children: [
            Align(
              alignment: Alignment.center,
              child: UserAvatar(
                url: "https://picsum.photos/200",
                onClick: () {},
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "User Name",
              style: textTheme.titleHighlight01.copyWith(
                color: colorScheme.neutralN900,
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                context.tr("userProfileGeneral"),
                style: textTheme.captionMedium01.copyWith(
                  color: colorScheme.neutralN600,
                ),
              ),
            ),
            const SizedBox(height: 8),
            UserProfileItem(
              title: context.tr("userProfilePersonalData"),
              description: context.tr("userProfileViewYourPersonalData"),
              icon: "assets/icon/icon-personal-24.svg",
              accent: colorScheme.primaryN200,
              showAction: true,
              onClick: () {},
            ),
            const SizedBox(height: 16),
            UserProfileItem(
              title: context.tr("userProfileAccountSettings"),
              icon: "assets/icon/icon-settings-24.svg",
              accent: colorScheme.primaryN200,
              showAction: true,
              onClick: () {
                AccountSettingsRoute().push(context);
              },
            ),
            const SizedBox(height: 32),
            UserProfileItem(
              title: context.tr("userProfileLogOut"),
              icon: "assets/icon/icon-log-out-24.svg",
              accent: colorScheme.errorN200,
              showAction: false,
              onClick: () {},
            )
          ],
        ));
  }
}
