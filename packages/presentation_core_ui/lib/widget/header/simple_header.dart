import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';

import '../../configure/default_configure.dart';
import '../button/icon/action_button.dart';
import 'header_divider_controller.dart';

class SimpleHeader extends StatefulWidget implements PreferredSizeWidget{
  final String? title;
  final VoidCallback onPressed;

  final HeaderDividerController headerDividerController;

  const SimpleHeader({
    super.key,
    required this.title,
    required this.onPressed,
    required this.headerDividerController,
  });

  @override
  State<StatefulWidget> createState() {
    return _SimpleHeader();
  }

  @override
  Size get preferredSize =>  const Size.fromHeight(75);
}

class _SimpleHeader extends State<SimpleHeader> {
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
          child: Row(
            children: [
              ActionButton(
                icon: SvgPicture.asset(
                  width: 24,
                  height: 24,
                  'assets/icon/icon-left-24.svg',
                  package: "presentation_core_ui",
                ),
                onPressed: widget.onPressed,
              ),
              Expanded(
                  child: Center(
                      child: Padding(
                padding: EdgeInsets.only(right: 24.0),
                child: widget.title != null
                    ? Text(widget.title!,
                        style: textTheme.bodyHighlight01
                            .copyWith(color: colorScheme.neutralN900))
                    : const SizedBox.shrink(),
              ))),
            ],
          )),
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
