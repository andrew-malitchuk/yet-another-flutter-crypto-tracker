import 'package:domain_repository/entity/crypto_asset_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';

class Stats extends StatelessWidget {
  CryptoAssetEntity asset;

  Stats({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.neutralN0,
        border: Border.all(color: colorScheme.neutralN300, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(mainAxisSize: MainAxisSize.max, children: [
            //
            Expanded(
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          "assets/icon/icon-market-cup-16.svg",
                          package: "presentation_core_ui",
                          width: 16,
                          height: 16,
                        ),
                        SizedBox(width: 4),
                        Text(context.tr("detalizationMarketCap"),
                            style: textTheme.caption01.copyWith(
                              color: colorScheme.neutralN900,
                            )),
                      ],
                    ))),
            Expanded(
                child: Align(
                    alignment: Alignment.topRight,
                    child: Text("\$ ${(asset.marketCapUsd).toStringAsFixed(2)}",
                        style: textTheme.bodyMedium02.copyWith(
                          color: colorScheme.neutralN900,
                        )))),
          ]),
          //
          Row(mainAxisSize: MainAxisSize.max, children: [
            Expanded(
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          "assets/icon/icon-start-16.svg",
                          package: "presentation_core_ui",
                          width: 16,
                          height: 16,
                        ),
                        SizedBox(width: 4),
                        Text(context.tr("detalizationPopularity"),
                            style: textTheme.caption01.copyWith(
                              color: colorScheme.neutralN900,
                            )),
                      ],
                    ))),
            Expanded(
                child: Align(
                    alignment: Alignment.topRight,
                    child: Text(asset.rank,
                        style: textTheme.bodyMedium02.copyWith(
                          color: colorScheme.neutralN900,
                        ))))
          ]),
          //
          Row(mainAxisSize: MainAxisSize.max, children: [
            Expanded(
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          asset.changePercent24Hr >= 0
                              ? "assets/icon/icon-growth-16.svg"
                              : "assets/icon/icon-drop-16.svg",
                          package: "presentation_core_ui",
                          width: 16,
                          height: 16,
                        ),
                        SizedBox(width: 4),
                        Text(context.tr(
                            asset.changePercent24Hr >= 0?
                            "detalizationGrowth": "detalizationDrop"),
                            style: textTheme.caption01.copyWith(
                              color: colorScheme.neutralN900,
                            )),
                      ],
                    ))),
            Expanded(
                child: Align(
                    alignment: Alignment.topRight,
                    child:
                        Text("${asset.changePercent24Hr.toStringAsFixed(2)}%",
                            style: textTheme.bodyMedium02.copyWith(
                              color: asset.changePercent24Hr >= 0
                                  ? colorScheme.neutralN900
                                  : colorScheme.errorN900,
                            ))))
          ]),
        ],
      ),
    );
  }
}
