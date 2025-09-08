import 'package:flutter/material.dart';

enum ThemeStyle { light, dark }

const primary = Color(0xFFFCC946);

final theme = ThemeData(
  primaryColor: primary,
  primaryColorDark: Color(0xFFE7B73F),
  disabledColor: Color(0xFFD9D9D9),
  fontFamily: 'Montserrat',
  colorScheme: ColorScheme.fromSeed(seedColor: primary),
);
