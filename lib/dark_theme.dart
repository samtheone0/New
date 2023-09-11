// dark_mode.dart

import 'package:flutter/material.dart';

const darkAppBarGradient = LinearGradient(
  colors: [Colors.black, Colors.grey],
  begin: Alignment.topLeft,
  end: Alignment.topLeft,
);

const darkBodyGradient = LinearGradient(
  colors: [Colors.black, Colors.grey],
  begin: Alignment.topLeft,
  end: Alignment.topLeft,
);

const darkInputFieldGradient = LinearGradient(
  colors: [Colors.black, Colors.grey],
  begin: Alignment.bottomRight,
  end: Alignment.bottomRight,
);

const darkButtonGradient = LinearGradient(
  colors: [Colors.black, Colors.grey],
  begin: Alignment.bottomRight,
  end: Alignment.bottomRight,
);

const darkBackButtonGradient = LinearGradient(
  colors: [Colors.black, Colors.grey],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  colorScheme: const ColorScheme.dark(
    background: Colors.black,
  ),
);
