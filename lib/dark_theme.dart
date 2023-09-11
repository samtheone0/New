import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  colorScheme: const ColorScheme.dark(
    background: Colors.black,
  ),
);

final LinearGradient darkAppBarGradient = LinearGradient(
  colors: [Colors.black, Colors.grey],
  begin: Alignment.topLeft,
  end: Alignment.topLeft,
);

final LinearGradient darkBodyGradient = LinearGradient(
  colors: [Colors.black, Colors.grey],
  begin: Alignment.topLeft,
  end: Alignment.topLeft,
);

final LinearGradient darkInputFieldGradient = LinearGradient(
  colors: [Colors.black, Colors.grey],
  begin: Alignment.bottomRight,
  end: Alignment.bottomRight,
);

final LinearGradient darkButtonGradient = LinearGradient(
  colors: [Colors.black, Colors.grey],
  begin: Alignment.bottomRight,
  end: Alignment.bottomRight,
);

final LinearGradient darkBackButtonGradient = LinearGradient(
  colors: [Colors.black, Colors.grey],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);
