import 'package:flutter/material.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';

void showSheet(BuildContext context, Widget content) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final textTheme = theme.textTheme;

  showModalBottomSheet(
    context: context,
    backgroundColor: colorScheme.neutralN0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    showDragHandle: true,
    builder: (_) {
      return content;
    },
  );
}
