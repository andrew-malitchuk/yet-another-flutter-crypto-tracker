import 'package:flutter/material.dart';
import 'package:presentation_core_ui/widget/field/simple_field.dart';

class DateTimeField extends StatelessWidget {
  const DateTimeField({
    super.key,
    required this.label,
    this.onTap,
    this.readOnly = false,
  });

  final String label;
  final VoidCallback? onTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: SimpleField(
          label: label,
          suffixIcon: "assets/icon/icon-calendar-24.svg",
        ),
      ),
    );
  }
}
