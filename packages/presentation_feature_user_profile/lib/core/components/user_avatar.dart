import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserAvatar extends StatefulWidget {
  final String url;

  final VoidCallback onClick;

  const UserAvatar({
    required this.url,
    required this.onClick,
    super.key,
  });

  @override
  _UserAvatarState createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
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
    return GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: SizedBox(
            width: 88,
            height: 88,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(widget.url),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4),
                    BlendMode.srcATop,
                  ),
                ),
              ),
              child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      width: 24,
                      height: 24,
                      child: _isPressed
                          ? SvgPicture.asset(
                              "assets/icon/icon_edit_24.svg",
                              package: "presentation_core_ui",
                              width: 24,
                              height: 24,
                            )
                          : null)),
            )));
  }
}
