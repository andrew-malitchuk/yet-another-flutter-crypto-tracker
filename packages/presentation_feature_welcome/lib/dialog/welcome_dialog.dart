// Function to show Persistent Bottom Sheet
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';
import 'package:presentation_core_ui/miscellaneous/dialog/general_dialog.dart';
import 'package:presentation_core_ui/widget/button/primary/primary_button.dart';

/// Function to show a welcome dialog
///
/// __References:__
/// - [Figma](https://www.figma.com/design/KTysYAkUWAyTTryh4IWzjU/Android-School-App-UI?node-id=74-3416&t=KZvLu9K7FxKgQTQ6-4)
void showWelcomeDialog(BuildContext context) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final textTheme = theme.textTheme;

  showSheet(
    context,
    SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              tr("welcomeDialogTitle"),
              style: textTheme.bodyHighlight01.copyWith(
                color: colorScheme.neutralN900,
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              tr("welcomeDialogDescription"),
              style: textTheme.body02.copyWith(
                color: colorScheme.neutralN900,
              ),
            ),
            Expanded(
                child: SvgPicture.asset(
              "assets/icon/image-transfer-225-170.svg",
              package: "presentation_core_ui",
            )),
            PrimaryButton(
              onClick: () {
                Navigator.of(context).pop();
              },
              title: tr("generalContinue"),
            )
          ],
        ),
      ),
    ),
  );
}
