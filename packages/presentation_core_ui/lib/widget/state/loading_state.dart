import 'package:flutter/material.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_ui/widget/item/action_item.dart';
import 'package:presentation_core_ui/widget/item/asset_item.dart';
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
      child: ListView.builder(
        itemCount: 5, // Adjust the count based on your needs
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: AssetItem(name: "", asset: "", price: 1.1, onClick: () {}));
        },
      ),
    );
  }
}
