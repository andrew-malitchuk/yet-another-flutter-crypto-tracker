import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';
import 'package:presentation_core_ui/layout/safe_scaffold.dart';
import 'package:presentation_core_ui/layout/scrollable_column.dart';
import 'package:presentation_core_ui/widget/header/header_divider_controller.dart';
import 'package:presentation_core_ui/widget/header/simple_header.dart';
import 'package:presentation_core_ui/widget/state/error_state.dart';
import 'package:presentation_feature_account_settings/core/navigation/account_settings_navigation.dart';
import 'package:presentation_feature_user_details/core/navigation/user_details_navigation.dart';
import 'package:presentation_feature_welcome/core/navigation/welcome_navigation.dart';

import 'bloc/user_profile_bloc.dart';
import 'bloc/user_profile_event.dart';
import 'bloc/user_profile_state.dart';
import 'core/components/loading_widget.dart';
import 'core/components/user_avatar.dart';
import 'core/components/user_profile_item.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  final HeaderDividerController headerDividerController =
      HeaderDividerController();

  File? _image;
  String? _base64String;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final image = File(picked.path);
      final bytes = await image.readAsBytes();
      final base64 = base64Encode(bytes);

      setState(() {
        _image = image;
        _base64String = base64;
      });

      context.read<UserProfileBloc>().add(
        UserProfileAvatarEvent(base64String: base64),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    context.read<UserProfileBloc>().add(UserProfileLoadEvent());
  }

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
        body: _buildView(context));
  }

  Widget _buildView(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return BlocListener<UserProfileBloc, UserProfileState>(
        listener: (context, state) {
          if (state is UserProfileEmpty) {
            WelcomeRoute().push(context);
          }
        },
        child: BlocBuilder<UserProfileBloc, UserProfileState>(
          bloc: context.read<UserProfileBloc>(),
          builder: (context, state) {
            switch (state) {
              case UserProfileErrorState():
                return ErrorState(onClick: null);
              case UserProfileLoadedState():
                return _buildContent(context, state);
              default:
                return LoadingWidget();
            }
          },
        ));
  }

  Widget _buildContent(BuildContext context, [UserProfileLoadedState? state]) {
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
                base64: state?.avatar ?? "",
                onClick: () {
                  _pickImage();
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(
              state?.data ?? "Welcome, User",
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
              onClick: () {
                UserDetailsRoute().push(context);
              },
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
              onClick: () {
                context.read<UserProfileBloc>().add(UserProfileLogOutEvent());
              },
            )
          ],
        ));
  }
}
