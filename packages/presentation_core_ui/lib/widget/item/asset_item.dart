import 'package:flutter/material.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';

import '../../configure/default_configure.dart';

/// A widget that represents an asset item.
///
/// __References:__
///
/// - [Figma](https://www.figma.com/design/KTysYAkUWAyTTryh4IWzjU/Android-School-App-UI?node-id=613-5338&t=W9ldOpQ00qhgZHQp-4)
class AssetItem extends StatefulWidget {
  final String name;
  final String asset;
  final double price;
  final double changePercent24Hr;
  final VoidCallback onClick;

  const AssetItem({
    required this.name,
    required this.asset,
    required this.price,
    required this.changePercent24Hr,
    super.key,
    required this.onClick,
  });

  @override
  State<StatefulWidget> createState() => _AssetItemState();
}

class _AssetItemState extends State<AssetItem> {
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
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textAlign: TextAlign.start,
                        widget.name,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyHighlight01.copyWith(
                          color: colorScheme.neutralN900,
                        ),
                        maxLines: 1,
                      ),
                      Text(
                        widget.asset,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.caption01.copyWith(
                          color: colorScheme.neutralN600,
                        ),
                        maxLines: 1,
                      )
                    ],
                  ),
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      textAlign: TextAlign.end,
                      "\$${widget.price.toStringAsFixed(2)}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyHighlight01.copyWith(
                        color: colorScheme.neutralN900,
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                          textAlign: TextAlign.end,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          "${widget.changePercent24Hr.toStringAsFixed(2)}%",
                          style: textTheme.bodyMedium02.copyWith(
                            color: widget.changePercent24Hr >= 0
                                ? colorScheme.successN900
                                : colorScheme.errorN900,
                          )))
                ]),
              ],
            ),
          ),
        ));
  }
}
