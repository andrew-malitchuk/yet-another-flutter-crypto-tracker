import 'package:flutter/material.dart';

extension CustomTextStyles on TextTheme {
  TextStyle get titleHighlight01 => const TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w700,
        // 700 → FontWeight.w700
        fontSize: 24,
        // 24px font size
        height: 32 / 24,
        // line-height / font-size → 1.333
        letterSpacing: 0,
        // 0% → 0.0
        textBaseline: TextBaseline.alphabetic,
      );

  TextStyle get subtitleHighlight01 => const TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w700,
        fontSize: 18,
        height: 24 / 18,
        letterSpacing: 0,
      );

  TextStyle get body02 => const TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w400,
        // 400 = normal
        fontSize: 14,
        // 14px font size
        height: 20 / 14,
        // line-height = 20px → height = 1.428
        letterSpacing: 0, // 0% → 0.0
      );

  TextStyle get bodyHighlight01 => const TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w700,
        // 700 = bold
        fontSize: 16,
        height: 24 / 16,
        // line-height: 24px → height = 1.5
        letterSpacing: 0, // 0%
      );

  TextStyle get bodyMedium02 => const TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 20 / 14,
        letterSpacing: 0,
      );

  TextStyle get ctaHighlight01 => const TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w700,
        // 700 = bold
        fontSize: 16,
        // 16px
        height: 24 / 16,
        // line-height: 24px → height = 1.5
        letterSpacing: 0, // 0%
      );

  TextStyle get ctaMedium02 => const TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w500,
        // 500 = medium
        fontSize: 12,
        height: 16 / 12,
        // 1.333
        letterSpacing: 0,
        decorationStyle: TextDecorationStyle.solid,
        decorationThickness:
            1, // 0% is not supported; 1.0 is minimal visible line
      );

  TextStyle get ctaUnderlineMedium02 => const TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w500,
        // 500 = medium
        fontSize: 12,
        height: 16 / 12,
        // 1.333
        letterSpacing: 0,
        decoration: TextDecoration.underline,
        decorationStyle: TextDecorationStyle.solid,
        decorationThickness:
            1, // 0% is not supported; 1.0 is minimal visible line
      );

  TextStyle get caption01 => const TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w400,
        // 400 = normal
        fontSize: 12,
        // 12px
        height: 16 / 12,
        // line-height: 16px → height = 1.333
        letterSpacing: 0, // 0%
      );

  TextStyle get caption02 => const TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w400,
        fontSize: 10,
        height: 12 / 10,
        letterSpacing: 0,
      );

  TextStyle get captionMedium01 => const TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w500,
        fontSize: 12,
        height: 16 / 12,
        letterSpacing: 0,
      );
}
