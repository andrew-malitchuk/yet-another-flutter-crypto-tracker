import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';
import 'package:presentation_core_ui/widget/button/primary/primary_button.dart';

class ErrorState extends StatelessWidget {
  VoidCallback? onClick;

  ErrorState({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Center(
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  context.tr("generalError"),
                  style: textTheme.bodyMedium02
                      .copyWith(color: colorScheme.neutralN900),
                ),
                SizedBox(height: 8),
                if (onClick != null)
                  PrimaryButton(
                      title: context.tr("generalTryAgain"), onClick: onClick!)
              ],
            )));
  }
}
