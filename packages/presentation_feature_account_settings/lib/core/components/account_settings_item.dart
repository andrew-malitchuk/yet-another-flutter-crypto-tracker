
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';
import 'package:presentation_core_ui/configure/default_configure.dart';
import 'package:presentation_feature_account_settings/core/components/switch_advance.dart';

class AccountSettingsItem extends StatefulWidget {
  final String title;
  final String? description;
  final String icon;
  final bool showAction;
  final Color accent;
  final ValueChanged<bool> onChanged;
  final bool value;

  const AccountSettingsItem({
    required this.title,
    this.description,
    required this.icon,
    required this.showAction,
    required this.accent,
    super.key,
    required this.onChanged,
    required this.value,
  });

  @override
  State<StatefulWidget> createState() => _AccountSettingsItemState();
}

class _AccountSettingsItemState extends State<AccountSettingsItem> {
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
    widget.onChanged(!widget.value);
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
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: widget.accent,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        widget.icon,
                        package: "presentation_core_ui",
                        width: 24,
                        height: 24,
                      )),
                ),
                SizedBox(width: 8),
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      widget.title,
                      style: textTheme.bodyHighlight01.copyWith(
                        color: colorScheme.neutralN900,
                      ),
                    ),
                    widget.description != null
                        ? Column(
                            children: [
                              SizedBox(height: 4),
                              Text(
                                textAlign: TextAlign.start,
                                widget.description!,
                                style: textTheme.caption01.copyWith(
                                  color: colorScheme.neutralN900,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                )),
                AdvancedSwitch(
                    // activeColor: colorScheme.neutralN0,
                    activeBorderColor: colorScheme.primaryN900,
                    inactiveBorderColor: colorScheme.neutralN600,

                    // inactiveColor: colorScheme.neutralN0,

                    activeBackgroundColor: colorScheme.primaryN900,
                    inactiveBackgroundColor: colorScheme.neutralN0,
                    activeThumbColor: colorScheme.neutralN0,
                    inactiveThumbColor: colorScheme.neutralN600,
                    value: widget.value,
                    onChanged: widget.onChanged),
              ],
            ),
          ),
        ));
  }
}
