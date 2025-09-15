import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';
import 'package:presentation_core_ui/miscellaneous/formatter/formatter_phone.dart';
import 'package:presentation_core_ui/widget/field/datetime_field.dart';
import 'package:presentation_core_ui/widget/field/operator/operator_field.dart';
import 'package:presentation_core_ui/widget/field/operator/operator_value.dart';
import 'package:presentation_core_ui/widget/field/simple_field.dart';
import 'package:shimmer/shimmer.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Shimmer.fromColors(
      baseColor: colorScheme.neutralN0,
      highlightColor: colorScheme.neutralN300,
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    tr("userDetailsTitle"),
                    style: textTheme.titleHighlight01.copyWith(
                      color: colorScheme.neutralN900,
                    ),
                    textAlign: TextAlign.left,
                  ))),
          Padding(
              padding: EdgeInsets.only(top: 8, left: 16, right: 16),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    tr("userDetailsDetails"),
                    style: textTheme.body02.copyWith(
                      color: colorScheme.neutralN900,
                    ),
                    textAlign: TextAlign.left,
                  ))),
          Padding(
              padding: EdgeInsets.only(top: 24, left: 16, right: 16),
              child: SimpleField(
                label: tr("generalFirstName"),
              )),
          Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: SimpleField(
                label: tr("generalLastName"),
              )),
          Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: SimpleField(
                label: tr("generalEmail"),
              )),
          Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Row(children: [
                Flexible(
                  flex: 1,
                  child: OperatorField(
                    operators: [
                      OperatorValue(
                        label: "+380",
                        icon: 'assets/icon/icon-ua-flag-24.svg',
                      ),
                    ],
                    hint: tr("generalOperatorArea"),
                    onSaved: (value) {},
                  ),
                ),
                SizedBox(width: 16),
                Flexible(
                  flex: 2,
                  child: SimpleField(
                    label: tr("generalPhone"),
                    inputFormatters: PhoneFormatter(),
                    length: 14,
                  ),
                ),
              ])),
          Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: DateTimeField(
                label: tr("generalDateOfBirth"),
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  ).then((value) {
                    if (value != null) {
                      // Handle the selected date
                    }
                  });
                },
              )),
        ],
      )
    );
  }
}
