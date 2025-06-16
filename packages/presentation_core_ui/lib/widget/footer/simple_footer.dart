import 'package:flutter/material.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';

import '../../configure/default_configure.dart';

class SimpleFooterController extends ChangeNotifier {
  bool isVisibility = false;

  void setVisibility(bool visibility) {
    isVisibility = visibility;
    notifyListeners();
  }

  void setVisible() {
    setVisibility(true);
  }

  void setUnvisible() {
    setVisibility(false);
  }
}

class SimpleFooter extends StatefulWidget {
  final Widget content;

  final SimpleFooterController simpleFooterController;

  const SimpleFooter({
    super.key,
    required this.simpleFooterController,
    required this.content,
  });

  @override
  State<StatefulWidget> createState() => _SimpleFooterState();
}

class _SimpleFooterState extends State<SimpleFooter> {
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

    widget.simpleFooterController.addListener(() {
      toggleOpacity(widget.simpleFooterController.isVisibility);
    });
    return Column(children: [
      AnimatedOpacity(
          opacity: _opacity,
          duration:
              Duration(milliseconds: DefaultConfigure.defaultAnimationDuration),
          child: Container(
            height: 1,
            color: colorScheme.neutralN300,
          )),
      Padding(padding: EdgeInsets.all(16), child: widget.content),
    ]);
  }
}
