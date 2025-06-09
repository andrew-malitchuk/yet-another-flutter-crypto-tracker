import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';

class SecondaryButton extends StatefulWidget {
  final String? icon;
  final String title;
  final VoidCallback onClick;

  const SecondaryButton({
    this.icon,
    required this.title,
    required this.onClick,
    super.key,
  });

  @override
  _SecondaryButtonState createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
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
          duration: Duration(milliseconds: 500),
          decoration: BoxDecoration(
            color:
            _isPressed ? colorScheme.secondaryN1000 : colorScheme.secondaryN900,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(children: [
                // TODO wtf
                if (widget.icon != null) ...[
                  SvgPicture.asset(
                    widget.icon!,
                    height: 32.0,
                    width: 43.0,
                    colorFilter: _isPressed
                        ? ColorFilter.mode(colorScheme.primary, BlendMode.clear)
                        : ColorFilter.mode(
                        colorScheme.secondary, BlendMode.clear),
                  ),
                  SizedBox(width: 16),
                ],
                Expanded(
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: textTheme.ctaHighlight01
                        .copyWith(color: colorScheme.neutralN0),
                  ),
                ),
              ])),
        ));
  }
}
