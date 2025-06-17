import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';

import '../../configure/default_configure.dart';
import 'header_divider_controller.dart';

/// A header widget for the portfolio section of the app.
///
/// __References:__
///
/// - [Figma](https://www.figma.com/design/KTysYAkUWAyTTryh4IWzjU/Android-School-App-UI?node-id=110-7330&t=LHlqQ1wNKCHhlFMO-4)
class PortfolioHeader extends StatefulWidget implements PreferredSizeWidget {
  final String welcome;
  final String? username;
  final VoidCallback onProfilePressed;

  final HeaderDividerController headerDividerController;

  // todo wtf
  const PortfolioHeader({
    super.key,
    required this.welcome,
    required this.username,
    required this.onProfilePressed,
    required this.headerDividerController,
  });

  @override
  State<StatefulWidget> createState() => _PortfolioHeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(63);
}

class _PortfolioHeaderState extends State<PortfolioHeader> {
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.welcome,
                      style: textTheme.caption01.copyWith(
                        color: colorScheme.neutralN900,
                      )),
                  Text(
                    widget.username ?? "",
                    style: textTheme.subtitleHighlight01.copyWith(
                      color: colorScheme.neutralN900,
                    ),
                  ),
                ],
              ),
              Spacer(),
              GestureDetector(
                  onTap: widget.onProfilePressed,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      "assets/icon/icon-profile-24.svg",
                      package: "presentation_core_ui",
                      width: 24,
                      height: 24,
                    ),
                  ))
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
