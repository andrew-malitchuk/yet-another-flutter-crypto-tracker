import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';

/// A widget that displays a rich text with clickable links for terms of service
///
/// __References:__
///
/// - [Figma](https://www.figma.com/design/KTysYAkUWAyTTryh4IWzjU/Android-School-App-UI?node-id=23-4045&t=afpNIFG7DwzGm8Lt-4)
class PrivacyPolicyText extends StatefulWidget {
  final VoidCallback onPrivacyClick;
  final VoidCallback onPolicyClick;

  const PrivacyPolicyText({
    super.key,
    required this.onPrivacyClick,
    required this.onPolicyClick,
  });

  @override
  State<StatefulWidget> createState() => _PrivacyPolicyTextState();
}

class _PrivacyPolicyTextState extends State<PrivacyPolicyText> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: context.tr("welcomeByContinuingYouAcceptOur"),
        style: textTheme.caption01.copyWith(color: colorScheme.neutralN900),
        children: [
          TextSpan(
            text: context.tr("welcomeTermsOfService"),
            style: textTheme.ctaUnderlineMedium02
                .copyWith(color: colorScheme.secondaryN1000),
            recognizer: TapGestureRecognizer()..onTap = widget.onPrivacyClick,
          ),
          TextSpan(
            text: context.tr("welcomeAnd"),
            style: textTheme.caption01.copyWith(color: colorScheme.neutralN900),
          ),
          TextSpan(
            text: context.tr("welcomePrivacyPolice"),
            style: textTheme.ctaUnderlineMedium02
                .copyWith(color: colorScheme.secondaryN1000),
            recognizer: TapGestureRecognizer()..onTap = widget.onPolicyClick,
          ),
        ],
      ),
    );
  }
}
