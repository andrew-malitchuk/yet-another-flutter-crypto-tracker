import 'package:flutter/material.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';

class Status extends StatelessWidget {
  final String text;

  const Status({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.successN900,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          child: Text(
            text,
            style: textTheme.caption02.copyWith(color: colorScheme.neutralN0),
          ),
        ),
      ),
    );
  }
}
