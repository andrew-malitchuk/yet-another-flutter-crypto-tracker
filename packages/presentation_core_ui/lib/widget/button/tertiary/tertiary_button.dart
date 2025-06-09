import 'package:flutter/material.dart';

class TertiaryButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;

  const TertiaryButton({
    required this.title,
    required this.onPressed,
    super.key,
  });

  @override
  _TertiaryButtonState createState() => _TertiaryButtonState();
}

class _TertiaryButtonState extends State<TertiaryButton> {
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
    final textTheme = theme.textTheme;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        padding: EdgeInsets.all(_isPressed ? 16.0 : 16.0),
        child: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: textTheme.headlineSmall?.copyWith(
              color: _isPressed ? colorScheme.surface : colorScheme.primary),
        ),
      ),
    );
  }
}
