import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';

import '../../configure/default_configure.dart';

class AccountCard extends StatefulWidget {
  final String balance;
  final String address;
  final VoidCallback onClick;

  const AccountCard({
    required this.balance,
    required this.address,
    required this.onClick,
    super.key,
  });

  @override
  _AccountCardState createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
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
      child: AnimatedScale(
        duration:
            Duration(milliseconds: DefaultConfigure.defaultAnimationDuration),
        scale: _isPressed ? 0.98 : 1.0,
        child: AnimatedContainer(
          alignment: Alignment.center,
          duration:
              Duration(milliseconds: DefaultConfigure.defaultAnimationDuration),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          child: AspectRatio(
            aspectRatio: 2,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background image
                SvgPicture.asset(
                  "assets/icon/image-balance-card.svg",
                  package: "presentation_core_ui",
                  fit: BoxFit.fitWidth,
                ),
                // Foreground overlay
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr("portfolioBalance"),
                          style: textTheme.caption01
                              .copyWith(color: colorScheme.neutralN0),
                        ),
                        SizedBox(height: 4),
                        Text(
                          widget.balance,
                          style: textTheme.subtitleHighlight01
                              .copyWith(color: colorScheme.neutralN200),
                        ),
                        Spacer(),
                        Text(
                          context.tr("portfolioAddress"),
                          style: textTheme.caption01
                              .copyWith(color: colorScheme.neutralN0),
                        ),
                        SizedBox(height: 4),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/icon/icon-copy-16.svg",
                                package: "presentation_core_ui",
                                width: 16,
                                height: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                widget.address,
                                style: textTheme.caption01
                                    .copyWith(color: colorScheme.neutralN200),
                              )
                            ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
