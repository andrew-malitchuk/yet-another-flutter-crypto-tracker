import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';
import 'package:presentation_core_ui/miscellaneous/dialog/general_dialog.dart';
import 'package:presentation_core_ui/widget/button/primary/primary_button.dart';
import 'package:presentation_core_ui/widget/button/secondary/secondary_button.dart';

/// Function to show the dialog asking for personal data
///
/// __References:__
///
/// - [Figma](https://www.figma.com/design/KTysYAkUWAyTTryh4IWzjU/Android-School-App-UI?node-id=161-5813&t=KZvLu9K7FxKgQTQ6-4)
void showAskPersonalDataDialog(BuildContext context) {
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                textAlign: TextAlign.center,
                tr("welcomeAskPersonalDataTitle"),
                style: textTheme.bodyHighlight01
                    .copyWith(color: colorScheme.neutralN900),
              ),
              SizedBox(height: 8),
              Text(
                textAlign: TextAlign.center,
                tr("welcomeAskPersonalDataDescription"),
                style:
                    textTheme.body02.copyWith(color: colorScheme.neutralN900),
              ),
              SizedBox(height: 16),
              SvgPicture.asset(
                "assets/icon/image-notes.svg",
                package: "presentation_core_ui",
              ),
              SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: SecondaryButton(
                      onClick: () {
                        Navigator.of(context).pop();
                      },
                      title: tr("generalSkip"),
                    ),
                  ),
                  SizedBox(width: 16),
                  Flexible(
                    fit: FlexFit.loose,
                    child: PrimaryButton(
                      onClick: () {
                        Navigator.of(context).pop();
                      },
                      title: tr("generalContinue"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ));
}
