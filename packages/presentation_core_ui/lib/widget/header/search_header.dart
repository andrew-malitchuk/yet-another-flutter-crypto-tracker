import 'package:flutter/material.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';

import '../../configure/default_configure.dart';
import '../button/miscellaneous/sort_button.dart';
import '../field/simple_field.dart';
import 'header_divider_controller.dart';

class SearchHeader extends StatefulWidget implements PreferredSizeWidget {
  final String hint;

  final HeaderDividerController headerDividerController;
  final ValueChanged<String>? onChanged;
  final VoidCallback onSortClick;

  // todo wtf
  const SearchHeader({
    super.key,
    required this.hint,
    required this.headerDividerController,
    this.onChanged,
    required this.onSortClick,
  });

  @override
  State<StatefulWidget> createState() => _SearchHeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(126);
}

class _SearchHeaderState extends State<SearchHeader> {
  double _opacity = 0.0;

  void toggleOpacity(bool isVisibility) {
    setState(() {
      if (isVisibility) {
        _opacity = 1.0;
      } else {
        _opacity = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    widget.headerDividerController.addListener(() {
      toggleOpacity(widget.headerDividerController.isVisibility);
    });

    return Column(children: [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: SimpleField(
            suffixIcon: "assets/icon/icon-search-24.svg",
            label: widget.hint,
            onChanged: widget.onChanged,
          )),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Align(
              alignment: Alignment.topRight,
              child: SortButton(
                  sortByProperty: 'price', isAscending: true, onClick: widget.onSortClick))),
      AnimatedOpacity(
          opacity: _opacity,
          duration:
              Duration(milliseconds: DefaultConfigure.defaultAnimationDuration),
          child: Container(
            height: 1,
            color: colorScheme.neutralN300,
          ))
    ]);
  }
}
