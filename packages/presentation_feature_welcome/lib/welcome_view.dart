import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';
import 'package:presentation_core_ui/widget/button/primary/primary_button.dart';
import 'package:presentation_feature_main/core/navigation/home_navigation.dart';
import 'package:presentation_feature_user_details/core/navigation/user_details_navigation.dart';
import 'package:presentation_feature_welcome/core/widget/privacy_policy_text.dart';

import 'bloc/welcome_cubit.dart';
import 'core/navigation/welcome_navigation.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {

  late final WelcomeCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = WelcomeCubit(context.read());
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return BlocProvider.value(
        value: _cubit,
        child: BlocListener<WelcomeCubit, WelcomeState>(
            listener: (context, state) {
              switch (state.status) {
                case WelcomeStatus.goToUserDetails:
                  WelcomeRoute().push(context);
                case WelcomeStatus.goToMarket:
                  MarketRoute().go(context);
                default:
                  break;
              }
            },
            child: Material(child: SafeArea(child: _buildContent(context)))));
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: () {
                    _cubit.unauthorize();
                  },
                  child: Text(context.tr("welcomeUnauthorized"),
                      style: textTheme.ctaUnderlineMedium02
                          .copyWith(color: colorScheme.secondaryN1000)))),
          Spacer(flex: 1),
          SvgPicture.asset(
            "assets/icon/image-welcome-page.svg",
            package: "presentation_core_ui",
            width: 328,
            height: 180,
          ),
          Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(context.tr("welcomeDialogTitle"),
                  textAlign: TextAlign.center,
                  style: textTheme.titleHighlight01
                      .copyWith(color: colorScheme.neutralN900))),
          Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(context.tr("welcomeDialogDescription"),
                  textAlign: TextAlign.center,
                  style: textTheme.body02
                      .copyWith(color: colorScheme.neutralN900))),
          Padding(
              padding: EdgeInsets.only(top: 24),
              child: PrimaryButton(
                title: context.tr("welcomeEnterYourDetails"),
                onClick: () {
                  UserDetailsRoute().push(context);
                },
              )),
          Spacer(flex: 1),
          Padding(
              padding: EdgeInsets.only(top: 24),
              child: PrivacyPolicyText(
                onPrivacyClick: () async {},
                onPolicyClick: () {},
              )),
        ],
      ),
    );
  }
}
