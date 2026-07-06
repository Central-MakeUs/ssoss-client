import 'package:flutter/material.dart';

/// Ssoss design system color palette.
class AppColors {
  const AppColors._();

  static const Color primary900 = Color(0xFF6F2D1B);
  static const Color primary800 = Color(0xFF882400);
  static const Color primary700 = Color(0xFFB43200);
  static const Color primary600 = Color(0xFFDA4000);
  static const Color primary500 = Color(0xFFF9560E);
  static const Color primary400 = Color(0xFFFF763B);
  static const Color primary300 = Color(0xFFFF9E70);
  static const Color primary200 = Color(0xFFFFCDB2);
  static const Color primary100 = Color(0xFFFFE1D3);
  static const Color primary50 = Color(0xFFFFF6F2);

  static const Color secondary900 = Color(0xFF4A3529);
  static const Color secondary800 = Color(0xFF654838);
  static const Color secondary700 = Color(0xFF7D5A47);
  static const Color secondary600 = Color(0xFF946B56);
  static const Color secondary500 = Color(0xFFAA7C64);
  static const Color secondary400 = Color(0xFFBE9984);
  static const Color secondary300 = Color(0xFFD1B5A5);
  static const Color secondary200 = Color(0xFFE2CFC3);
  static const Color secondary100 = Color(0xFFF1E6E0);
  static const Color secondary50 = Color(0xFFFCF7F4);

  static const Color neutral800 = Color(0xFF262626);
  static const Color neutral700 = Color(0xFF404040);
  static const Color neutral600 = Color(0xFF525252);
  static const Color neutral500 = Color(0xFF737373);
  static const Color neutral400 = Color(0xFFA1A1A1);
  static const Color neutral300 = Color(0xFFD4D4D4);
  static const Color neutral200 = Color(0xFFE5E5E5);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral50 = Color(0xFFFAFAFA);

  static const Color success700 = Color(0xFF007C4E);
  static const Color success500 = Color(0xFF2AD099);
  static const Color success50 = Color(0xFFE2FFF4);

  static const Color info700 = Color(0xFF00598A);
  static const Color info500 = Color(0xFF29BBFB);
  static const Color info50 = Color(0xFFDDF5FF);

  static const Color warning700 = Color(0xFF865500);
  static const Color warning500 = Color(0xFFFFA100);
  static const Color warning50 = Color(0xFFFFF6DF);

  static const Color error700 = Color(0xFF9B0000);
  static const Color error500 = Color(0xFFFF787E);
  static const Color error50 = Color(0xFFFFEEEE);

  static const Color black = Color(0xFF171717);
  static const Color white = Color(0xFFFFFFFF);

  static const LinearGradient gradientStrong = LinearGradient(
    colors: <Color>[primary500, primary400],
  );

  static const LinearGradient gradientLight = LinearGradient(
    colors: <Color>[primary50, primary100],
  );
}
