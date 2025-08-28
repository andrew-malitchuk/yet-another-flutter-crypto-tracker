import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_ui/layout/safe_scaffold.dart';
import 'package:presentation_core_ui/layout/scrollable_column.dart';
import 'package:presentation_core_ui/widget/header/header_divider_controller.dart';
import 'package:presentation_core_ui/widget/header/simple_header.dart';
import 'package:presentation_core_ui/widget/loader/loading_widget.dart';

import 'bloc/account_settings_bloc.dart';
import 'bloc/account_settings_event.dart';
import 'bloc/account_settings_state.dart';
import 'core/components/account_settings_item.dart';
import 'core/components/user_profile_item.dart';

class AccountSettingsView extends StatefulWidget {
  const AccountSettingsView({super.key});

  @override
  State<AccountSettingsView> createState() => _AccountSettingsViewState();
}

class _AccountSettingsViewState extends State<AccountSettingsView> {
  final HeaderDividerController headerDividerController =
      HeaderDividerController();

  @override
  void initState() {
    super.initState();

    context.read<AccountSettingsBloc>().add(AccountSettingsLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
        appBar: SimpleHeader(
          headerDividerController: headerDividerController,
          title: context.tr("userProfileAccountSettings"),
          onPressed: () {
            context.pop();
          },
        ),
        body: _buildView(context));
  }

  Widget _buildView(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return // TODO wtf
        BlocBuilder<AccountSettingsBloc, AccountSettingsState>(
      bloc: context.read<AccountSettingsBloc>(),
      builder: (context, state) {
        switch (state) {
          case AccountSettingsLoadedState():
            return _buildContent(context, state);
          default:
            return LoadingWidget();
        }
      },
    );
  }

  Widget _buildContent(BuildContext context, AccountSettingsLoadedState state) {
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
            AccountSettingsItem(
              title: context.tr("accountSettingsAppNotification"),
              description: context.tr("accountSettingsEnabledByDefault"),
              icon: "assets/icon/icon-notification-24.svg",
              accent: colorScheme.primaryN200,
              showAction: true,
              value: state.isNotificationEnabled,
              onChanged: (enabled) async {
                context.read<AccountSettingsBloc>().add(
                      AccountSettingsChangeNotificationEvent(
                          isEnabled: enabled),
                    );
              },
            ),
            const SizedBox(height: 16),
            AccountSettingsItem(
              title: context.tr("accountSettingsSignInWithFingerprint"),
              icon: "assets/icon/icon-touch-id-24.svg",
              accent: colorScheme.primaryN200,
              showAction: true,
              value: state.isBiometricEnabled,
              onChanged: (bool) {
                context
                    .read<AccountSettingsBloc>()
                    .add(AccountSettingsChangeBiometricEvent(isEnabled: bool));
              },
            ),
            const SizedBox(height: 16),
            UserProfileItem(
              title: context.tr("accountSettingsLanguage"),
              description: "English",
              icon: "assets/icon/icon-language-24.svg",
              accent: colorScheme.primaryN200,
              showAction: true,
              onClick: () {
                _showLanguageDialog(context);
              },
            )
          ],
        ));
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('accountSettingsLanguage'.tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('accountSettingsLanguageEng'.tr()),
              onTap: () {
                context.setLocale(const Locale('en'));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('accountSettingsLanguageUkr'.tr()),
              onTap: () {
                context.setLocale(const Locale('uk'));
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
