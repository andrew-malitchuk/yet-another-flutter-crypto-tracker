import 'package:domain_repository/entity/crypto_asset_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';
import 'package:presentation_core_ui/miscellaneous/dialog/general_dialog.dart';
import 'package:presentation_core_ui/widget/button/primary/primary_button.dart';
import 'package:presentation_core_ui/widget/field/simple_field.dart';

void showAddDialog(
  BuildContext context,
  CryptoAssetEntity asset,
  Function(CryptoAssetEntity) onSelected,
) {
  final amountController = TextEditingController(text: "");

  Widget buildContent(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textAlign: TextAlign.start,
                  asset.symbol,
                  style: textTheme.bodyHighlight01.copyWith(
                    color: colorScheme.neutralN900,
                  ),
                ),
                Text(
                  asset.name,
                  style: textTheme.caption01.copyWith(
                    color: colorScheme.neutralN600,
                  ),
                )
              ],
            ),
          ),
          Align(
            heightFactor: 1.5,
            alignment: Alignment.topRight,
            child: Text(
              textAlign: TextAlign.end,
              "${asset.priceUsd.toStringAsFixed(2)} \$",
              style: textTheme.bodyHighlight01.copyWith(
                color: colorScheme.neutralN900,
              ),
            ),
          ),
          SizedBox(width: 32),
          Align(
              heightFactor: 1.5,
              alignment: Alignment.topRight,
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: amountController,
                builder: (context, value, _) {
                  final amount = double.tryParse(value.text) ?? 1;
                  return Text(
                    "${(asset.priceUsd * amount).toStringAsFixed(2)} \$",
                    style: textTheme.bodyHighlight01.copyWith(
                      color: colorScheme.neutralN900,
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.neutralN0,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                            width: 1.0, color: colorScheme.neutralN300),
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              buildContent(context),
                              Divider(
                                color: colorScheme.neutralN300,
                                height: 1,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              SimpleField(
                                controller: amountController,
                                label: context.tr("addNewCoinAmount"),
                              )
                            ],
                          )),
                    ),
                    SizedBox(height: 32),
                    PrimaryButton(
                        title: context.tr("addNewCoin"),
                        onClick: () {
                          final assetToAdd = asset.copyWith(
                              amount: double.tryParse(amountController.text) ??
                                  1.0);

                          onSelected(assetToAdd);
                          Navigator.of(context).pop();
                        })
                  ]))));
}
