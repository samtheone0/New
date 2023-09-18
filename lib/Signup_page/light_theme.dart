// light_mode.dart

import 'package:flutter/material.dart';

const lightAppBarGradient = LinearGradient(
  colors: [Color(0xFFF0E29E), Color(0xFFDFD9C6)],
  begin: Alignment.topLeft,
  end: Alignment.topLeft,
);

const lightBodyGradient = LinearGradient(
  colors: [Color(0xFFF0E29E), Color(0xFFDFD9C6)],
  begin: Alignment.topLeft,
  end: Alignment.topLeft,
);

const lightInputFieldGradient = LinearGradient(
  colors: [Colors.white, Colors.grey],
  begin: Alignment.bottomRight,
  end: Alignment.bottomRight,
);

const lightButtonGradient = LinearGradient(
  colors: [Color(0xFFF0E29E), Color(0xFFDFD9C6)],
  begin: Alignment.bottomRight,
  end: Alignment.bottomRight,
);

const lightBackButtonGradient = LinearGradient(
  colors: [Color(0xFFF0E29E), Color(0xFFDFD9C6)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFFF0E29E),
  colorScheme: const ColorScheme.light(
    background: Color(0xFFF0E29E),
  ),
);
