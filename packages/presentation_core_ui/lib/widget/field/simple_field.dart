import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';

class SimpleField extends StatefulWidget {
  final String label;
  final TextInputFormatter? inputFormatters;
  final int? length;
  final String? suffixIcon;
  final ValueChanged<String>? onChanged;
  final String? regexPattern;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  const SimpleField(
      {super.key,
      required this.label,
      this.inputFormatters,
      this.length,
      this.suffixIcon,
      this.regexPattern,
      this.keyboardType,
      this.onChanged,
      this.controller,
      });

  @override
  State<SimpleField> createState() => _SimpleFieldState();
}

class _SimpleFieldState extends State<SimpleField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isFocused = _focusNode.hasFocus;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isFocused ? colorScheme.primaryN600 : colorScheme.neutralN300,
        ),
        borderRadius: BorderRadius.circular(8.0),
        color: isFocused ? colorScheme.neutralN100 : colorScheme.neutralN0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        maxLength: widget.length,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          suffixIconConstraints: BoxConstraints(
            minWidth: 24,
            minHeight: 24,
          ),
          suffixIcon: SvgPicture.asset(
            widget.suffixIcon ?? "",
            package: "presentation_core_ui",
          ),
          counterText: "",
          labelText: widget.label,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: InputBorder.none,
          labelStyle:
              textTheme.caption01.copyWith(color: colorScheme.neutralN600),
        ),
        style: textTheme.body02.copyWith(color: colorScheme.neutralN900),
        inputFormatters: widget.regexPattern != null
            ? [FilteringTextInputFormatter.allow(RegExp(widget.regexPattern!))]
            : (widget.inputFormatters != null ? [widget.inputFormatters!] : []),
        onChanged: widget.onChanged,
      ),
    );
  }
}
