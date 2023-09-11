import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFFF0E29E),
  colorScheme: const ColorScheme.light(
    background: Color(0xFF231EAB),
  ),
);

final LinearGradient lightAppBarGradient = LinearGradient(
  colors: [Color(0xFFF0E29E), Color(0xFFDFD9C6)],
  begin: Alignment.topLeft,
  end: Alignment.topLeft,
);

final LinearGradient lightBodyGradient = LinearGradient(
  colors: [Color(0xFFF0E29E), Color(0xFFDFD9C6)],
  begin: Alignment.topLeft,
  end: Alignment.topLeft,
);

final LinearGradient lightInputFieldGradient = LinearGradient(
  colors: [Colors.white, Colors.grey],
  begin: Alignment.bottomRight,
  end: Alignment.bottomRight,
);

final LinearGradient lightButtonGradient = LinearGradient(
  colors: [Color(0xFFF0E29E), Color(0xFFDFD9C6)],
  begin: Alignment.bottomRight,
  end: Alignment.bottomRight,
);

final LinearGradient lightBackButtonGradient = LinearGradient(
  colors: [Color(0xFFF0E29E), Color(0xFFDFD9C6)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);
