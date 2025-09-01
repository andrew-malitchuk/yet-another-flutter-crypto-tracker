import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';
import 'package:presentation_feature_detalization/core/components/widget/status.dart';
import 'package:shimmer/shimmer.dart';

import 'line_chart.dart';

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
          padding: EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.tr("generalLoading"),

                  style: textTheme.ctaHighlight01
                      .copyWith(color: colorScheme.neutralN900),
                ),
                Text(
                  context.tr("generalLoading"),

                  style: textTheme.titleHighlight01
                      .copyWith(color: colorScheme.neutralN900),
                ),
                SizedBox(height: 6),
                SvgPicture.asset("assets/icon/icon-exchange-24.svg",
                    package: "presentation_core_ui", width: 16, height: 16),
                SizedBox(height: 4),
                Text(
                 context.tr("generalLoading"),
                  style: textTheme.caption02
                      .copyWith(color: colorScheme.neutralN900),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(left: 64, right: 8),
                            child: Status(
                              text:                  context.tr("generalLoading"),
                            ))),
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(right: 64, left: 8),
                            child: Status(
                              text:                  context.tr("generalLoading"),
                            ))),
                  ],
                ),
                SizedBox(height: 16),
                LineChartPrice(),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    context.tr("marketStats"),
                    style: textTheme.titleHighlight01
                        .copyWith(color: colorScheme.neutralN900),
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          )),
    );
  }
}
