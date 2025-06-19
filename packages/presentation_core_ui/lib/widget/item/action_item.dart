import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';

import '../../configure/default_configure.dart';

class ActionItem extends StatefulWidget {
  final String name;
  final String icon;
  final Color foregroundColor;
  final VoidCallback onClick;

  const ActionItem({
    required this.name,
    required this.icon,
    required this.foregroundColor,
    super.key,
    required this.onClick,
  });

  @override
  State<StatefulWidget> createState() => _ActionItemState();
}

class _ActionItemState extends State<ActionItem> {
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
          duration:
              Duration(milliseconds: DefaultConfigure.defaultAnimationDuration),
          decoration: BoxDecoration(
            color: colorScheme.neutralN0,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              width: 1.0,
              color: _isPressed
                  ? colorScheme.primaryN600
                  : colorScheme.neutralN300,
            ),
          ),
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  SvgPicture.asset(
                    widget.icon,
                    package: "presentation_core_ui",
                    width: 24,
                    height: 24,
                    // colorFilter: ColorFilter.mode(
                    //     widget.foregroundColor, BlendMode.clear),
                  ),
                  // SizedBox(height: 4),
                  Text(widget.name,
                      style: textTheme.captionMedium01
                          .copyWith(color: widget.foregroundColor))
                ],
              )),
        ));
  }
}
