import 'package:flutter/material.dart';

enum ThemeStyle { light, dark }

final Map<ThemeStyle, ThemeData> themes = {
  ThemeStyle.light: _lightTheme,
  ThemeStyle.dark: _darkTheme,
};

const _primary = Color(0xFFFCC946);

final _lightTheme = ThemeData(
  primaryColor: _primary,
  primaryColorDark: Color(0xFFE7B73F),
  disabledColor: Color(0xFFD9D9D9),
  fontFamily: 'Montserrat',
  colorScheme: ColorScheme.fromSeed(seedColor: _primary),
);

final _darkTheme = ThemeData(
  primaryColor: _primary,
  primaryColorDark: Color(0xFFE7B73F),
  disabledColor: Color(0xFF8E8E8E),
  cardColor: Color(0xFF33312c),
  scaffoldBackgroundColor: Color(0xFF1a1815),
  fontFamily: 'Montserrat',
  colorScheme: ColorScheme.fromSeed(
    seedColor: _primary,
    brightness: Brightness.dark,
  ),
);
