import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:presentation_core_ui/configure/default_configure.dart';

class AdvancedSwitch extends StatefulWidget {
  const AdvancedSwitch({
    super.key,
    required this.value,
    this.activeBorderColor = Colors.green,
    this.inactiveBorderColor = Colors.grey,

    this.activeBackgroundColor = Colors.grey,
    this.inactiveBackgroundColor = Colors.grey,

    this.activeThumbColor = Colors.grey,
    this.inactiveThumbColor = Colors.grey,

    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
    this.width = 50.0,
    this.height = 30.0,
    required this.onChanged,
  });

  /// Determines current state.
  final bool value;

  /// Determines background color for the active state.
  final Color activeBorderColor;

  /// Determines background color for the inactive state.
  final Color inactiveBorderColor;

  final Color activeBackgroundColor;
  final Color inactiveBackgroundColor;

  final Color activeThumbColor;
  final Color inactiveThumbColor;

  /// Determines border radius.
  final BorderRadius borderRadius;

  /// Determines width.
  final double width;

  /// Determines height.
  final double height;

  /// Called on interaction.
  final ValueChanged<bool> onChanged;

  @override
  _AdvancedSwitchState createState() => _AdvancedSwitchState();
}

class _AdvancedSwitchState extends State<AdvancedSwitch>
    with SingleTickerProviderStateMixin {
  final _duration = Duration(milliseconds: DefaultConfigure.defaultAnimationDuration);
  late AnimationController _animationController;
  late Animation<Color?> _thumbColorAnimation;
  late Animation<Color?> _borderColorAnimation;
  late Animation<Color?> _backgroundColorAnimation;
  late Animation<Alignment> _slideAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: _duration,
      value: widget.value ? 1.0 : 0.0,
    );

    _slideAnimation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(_animationController);

    _thumbColorAnimation = ColorTween(
      begin: widget.inactiveThumbColor,
      end: widget.activeThumbColor,
    ).animate(_animationController);

    _borderColorAnimation = ColorTween(
      begin: widget.inactiveBorderColor,
      end: widget.activeBorderColor,
    ).animate(_animationController);

    _backgroundColorAnimation= ColorTween(
      begin: widget.inactiveBackgroundColor,
      end: widget.activeBackgroundColor,
    ).animate(_animationController);

    super.initState();
  }

  @override
  void didUpdateWidget(AdvancedSwitch oldWidget) {
    if (oldWidget.value == widget.value) {
      return super.didUpdateWidget(oldWidget);
    }

    if (widget.value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
      widget.onChanged(!widget.value),
      child: Opacity(
        opacity: 1.0,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (_, child) {
            return Container(
              width: widget.width,
              height: widget.height,
              clipBehavior: Clip.antiAlias,
              //
              decoration: BoxDecoration(
                color: _backgroundColorAnimation.value,
                shape: BoxShape.rectangle,
                borderRadius: widget.borderRadius,
                border: Border.all(
                    width: 1.0,
                    color: _borderColorAnimation.value ?? Colors.cyan
                ),
              ),
              //
              child: child,
            );
          },
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Stack(
                children: [
                  Align(
                    alignment: _slideAnimation.value,
                    child: child,
                  ),
                ],
              );
            },
            child: _buildThumb(_thumbColorAnimation.value),
          ),
        ),
      ),
    );
  }

  Widget _buildThumb(Color? backgroundColor) {
    final size = Math.min(widget.width, widget.height) - 4;

    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.cyan,
        borderRadius: BorderRadius.circular(size / 2),
      ),
    );
  }
}
