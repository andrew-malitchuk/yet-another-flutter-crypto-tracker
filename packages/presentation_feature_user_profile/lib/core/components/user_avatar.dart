import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserAvatar extends StatefulWidget {
  final String base64;

  final VoidCallback onClick;

  const UserAvatar({
    required this.base64,
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
    try {
      if (widget.base64.trim().isEmpty) {
        throw const FormatException("Empty image");
      }

      final cleanBase64 = widget.base64.contains(',')
          ? widget.base64.split(',').last
          : widget.base64;

      final imageBytes = base64Decode(cleanBase64);

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
                image: MemoryImage(imageBytes),
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
                    : null,
              ),
            ),
          ),
        ),
      );
    } catch (e) {
      return GestureDetector(
        onTap: widget.onClick,
        child: Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey.shade300,
          ),
          child: Icon(Icons.person, size: 40, color: Colors.grey.shade600),
        ),
      );
    }
  }

}
