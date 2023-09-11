import 'package:App/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Color darkTextColor = Colors.black;
    Color lightTextColor = Colors.black;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: themeProvider.isDarkTheme ? darkAppBarGradient : lightAppBarGradient,
          ),
          child: AppBar(
            systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 65,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: themeProvider.isDarkTheme
                          ? darkBackButtonGradient
                          : lightBackButtonGradient,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        // Implement back button logic here
                      },
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      themeProvider.isDarkTheme ? Icons.light_mode : Icons.dark_mode,
                      color: Colors.black,
                    ),
                    onPressed: themeProvider.toggleTheme,
                  ),
                ],
              ),
            ),
            title: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                "cueprise",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkTheme ? darkTextColor : lightTextColor,
                ),
              ),
            ),
          ),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
            SizedBox(height: 16),
            Text(
              "Congratulations! Your registration was successful.",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
