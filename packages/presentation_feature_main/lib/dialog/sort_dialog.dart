import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';
import 'package:presentation_core_ui/miscellaneous/dialog/general_dialog.dart';

/// Displays a dialog for sorting items with multiple selection options.
///
/// __References:__
///
/// - [Figma](https://www.figma.com/design/KTysYAkUWAyTTryh4IWzjU/Android-School-App-UI?node-id=150-6177&t=rTOpyNfeMdXO33cY-4)
void showSortDialog(BuildContext context,
    Function(List<String> selectedItems, String selectedItem) onSelected) {
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
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        context.tr("generalSortBy"),
                        style: textTheme.bodyHighlight01.copyWith(
                          color: colorScheme.neutralN900,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    MultiSelectContainer(
                        maxSelectableCount: 1,
                        singleSelectedItem: true,
                        wrapSettings: WrapSettings(
                          runAlignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          spacing: 8,
                          runSpacing: 16,
                          alignment: WrapAlignment.start,
                        ),
                        alignments: MultiSelectAlignments(
                            crossAxisAlignment: CrossAxisAlignment.start),
                        items: <MultiSelectCard<String>>[
                          _getMultiSelectCard(
                              context, 'nameAZ', context.tr("sortByNameAZ")),
                          _getMultiSelectCard(
                              context, 'nameZA', context.tr("sortByNameZA")),
                          _getMultiSelectCard(context, 'priceIncrease',
                              context.tr("sortByPriceIncrease")),
                          _getMultiSelectCard(context, 'priceDecrease',
                              context.tr("sortByPriceDecrease")),
                          _getMultiSelectCard(context, 'percentDecline',
                              context.tr("sortPercentDecline")),
                          _getMultiSelectCard(context, 'percentageGrowth',
                              context.tr("sortPercentageDecline")),
                        ],
                        onChange: onSelected),
                  ]))));
}

/// Creates a MultiSelectCard with the specified value and label.
///
/// __References:__
///
/// - [Figma](https://www.figma.com/design/KTysYAkUWAyTTryh4IWzjU/Android-School-App-UI?node-id=150-6177&t=rTOpyNfeMdXO33cY-4)
_getMultiSelectCard(BuildContext context, String value, String label) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final textTheme = theme.textTheme;

  return MultiSelectCard(
    value: value,
    label: label,
    textStyles: MultiSelectItemTextStyles(
      selectedTextStyle:
          textTheme.bodyMedium02.copyWith(color: colorScheme.neutralN900),
      textStyle:
          textTheme.bodyMedium02.copyWith(color: colorScheme.neutralN900),
    ),
    decorations: MultiSelectItemDecorations(
      selectedDecoration: BoxDecoration(
        color: colorScheme.neutralN200,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.neutralN200, width: 1),
      ),
      decoration: BoxDecoration(
        color: colorScheme.neutralN100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.neutralN300, width: 1),
      ),
    ),
  );
}
