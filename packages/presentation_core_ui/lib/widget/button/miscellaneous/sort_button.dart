import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';

import '../../../configure/default_configure.dart';

class SortButton extends StatefulWidget {
  final String sortByProperty;
  final bool isAscending;
  final VoidCallback onClick;

  const SortButton(
      {super.key,
      required this.sortByProperty,
      required this.isAscending,
      required this.onClick});

  @override
  State<StatefulWidget> createState() => _SortButtonState();
}

class _SortButtonState extends State<SortButton> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    widget.onClick();
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedContainer(
            duration: Duration(
                milliseconds: DefaultConfigure.defaultAnimationDuration),
            decoration: BoxDecoration(
              color: colorScheme.neutralN0,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                width: 1.0,
                color: _isPressed
                    ? colorScheme.neutralN300
                    : colorScheme.neutralN0,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.tr("generalSortBy"),
                    style: textTheme.caption01
                        .copyWith(color: colorScheme.neutralN600),
                  ),
                  SizedBox(width: 2),
                  Text(
                    widget.sortByProperty,
                    style: textTheme.caption01
                        .copyWith(color: colorScheme.neutralN900),
                  ),
                  SvgPicture.asset(
                    widget.isAscending
                        ? "assets/icon/icon-sort-asc.svg"
                        : "assets/icon/icon-sort-desc.svg",
                    package: "presentation_core_ui",
                    width: 24,
                    height: 24,
                  )
                ],
              ),
            )));
  }
}
