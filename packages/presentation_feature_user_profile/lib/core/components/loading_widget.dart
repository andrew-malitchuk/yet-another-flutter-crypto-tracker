import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';
import 'package:presentation_core_ui/layout/scrollable_column.dart';
import 'package:presentation_feature_account_settings/core/components/user_profile_item.dart';
import 'package:presentation_feature_user_profile/core/components/user_avatar.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Shimmer.fromColors(
        baseColor: colorScheme.neutralN0,
        highlightColor: colorScheme.neutralN300,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ScrollableColumn(
              onOverScroll: (isOverScroll) {},
              children: [
                Align(
                  alignment: Alignment.center,
                  child: UserAvatar(
                    base64: "https://picsum.photos/200",
                    onClick: () {},
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  context.tr("generalLoading"),
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
                  onClick: () {},
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
            )));
  }
}
