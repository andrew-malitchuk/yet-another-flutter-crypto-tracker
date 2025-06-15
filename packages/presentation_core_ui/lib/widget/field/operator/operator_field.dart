import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';

import '../dropdown/dropdown_button2.dart';
import 'operator_value.dart';

class OperatorField extends StatefulWidget {
  final List<OperatorValue> operators;
  final String hint;
  final void Function(String?)? onSaved;

  // TODO wtf const
  OperatorField(
      {super.key, required this.operators, required this.hint, this.onSaved});

  String? _value;

  @override
  State<StatefulWidget> createState() => _OperatorFieldState();
}

class _OperatorFieldState extends State<OperatorField> {
  bool isExpanded = false;

  // TODO wtf const

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      children: [
        DropdownButtonFormField2<String>(
          onMenuStateChange: (expanded) {
            // todo wtf
            setState(() {
              isExpanded = expanded;
            });
          },
          isExpanded: true,
          decoration: InputDecoration(
            fillColor: colorScheme.neutralN0,
            focusColor: colorScheme.neutralN100,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.primaryN600, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.neutralN300, width: 1),
            ),
            filled: true,
            // Add Horizontal padding using menuItemStyleData.padding so it matches
            // the menu padding when button's width is not specified.
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            // Add more decoration..
          ),
          hint: Text(
            widget._value ?? widget.hint,
            style: textTheme.body02.copyWith(
              color: colorScheme.neutralN600,
            ),
          ),
          items: widget.operators
              .map((item) => DropdownItem<String>(
                  value: item.label,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        item.icon,
                        package: "presentation_core_ui",
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item.label,
                        style: textTheme.body02.copyWith(
                          color: colorScheme.neutralN900,
                        ),
                      )
                    ],
                  )))
              .toList(),
          onChanged: (value) {
            //Do something when selected item is changed.
            widget._value = value;
            widget.onSaved?.call(value);
          },
          onSaved: (value) {
           // widget.onSaved?.call(value);
          },
          iconStyleData: IconStyleData(
              icon: SvgPicture.asset(
            isExpanded
                ? 'assets/icon/icon-chevron-up-24.svg'
                : 'assets/icon/icon-chevron-down-24.svg',
            package: "presentation_core_ui",
            height: 24,
            width: 24,
          )),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              color: colorScheme.neutralN100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: colorScheme.primaryN600,
                width: 1,
              ),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ],
    );
  }
}
