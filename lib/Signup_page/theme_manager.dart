import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dark_theme.dart';
import 'light_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightTheme; // Initialize with the light theme

  final String _themePreferenceKey = 'themePreference';

  ThemeProvider() {
    _loadThemeFromPrefs();
  }

  ThemeData get themeData => _themeData;

  bool get isDarkTheme => _themeData.brightness == Brightness.dark;

  void toggleTheme() {
    _themeData = isDarkTheme ? lightTheme : darkTheme; // Toggle between light and dark themes
    _saveThemeToPrefs();
    notifyListeners();
  }

  Future<void> _loadThemeFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isDark = prefs.getBool(_themePreferenceKey) ?? false;
    _themeData = isDark ? darkTheme : lightTheme; // Set the theme based on user preference
    notifyListeners();
  }

  Future<void> _saveThemeToPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_themePreferenceKey, isDarkTheme);
  }
}
Color darkTextColor = Colors.black;
Color lightTextColor = Colors.black;

// Custom button style
ButtonStyle customButtonStyle(BuildContext context, bool isDarkTheme) {
  Color buttonColor = isDarkTheme ? Colors.black45 : Colors.white54;
  return ElevatedButton.styleFrom(
    foregroundColor: Theme.of(context).primaryColor,
    backgroundColor: buttonColor,
    shape: const CircleBorder(),
    padding: const EdgeInsets.all(16),
  );
}