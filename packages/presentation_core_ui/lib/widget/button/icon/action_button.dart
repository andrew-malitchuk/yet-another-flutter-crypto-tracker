import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';

import '../../../configure/default_configure.dart';

class ActionButton extends StatefulWidget {
  final SvgPicture icon;
  final VoidCallback onPressed;

  const ActionButton({
    required this.icon,
    required this.onPressed,
    super.key,
  });

  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
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
    widget.onPressed();
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

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedContainer(
          duration:
              Duration(milliseconds: DefaultConfigure.defaultAnimationDuration),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: _isPressed ? colorScheme.neutralN600 : colorScheme.neutralN200,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: widget.icon),
    );
  }
}
