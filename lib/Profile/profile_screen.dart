import 'package:App/Signup_page/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Signup_page/dark_theme.dart';
import '../Signup_page/light_theme.dart';
import '../Signup_page/theme_manager.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  final String email;
  final String appVersion;
  final Function(BuildContext) navigateToLoginScreen;

  const ProfileScreen({
    Key? key,
    required this.username,
    required this.email,
    required this.appVersion,
    required this.navigateToLoginScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Color darkTextColor = Colors.black;
    Color lightTextColor = Colors.black;

    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents white space below the SingleChildView
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Container(
          decoration: BoxDecoration(
            gradient:
            themeProvider.isDarkTheme ? darkAppBarGradient : lightAppBarGradient,
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
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
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      themeProvider.isDarkTheme
                          ? Icons.light_mode
                          : Icons.dark_mode,
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
                  color: themeProvider.isDarkTheme
                      ? darkTextColor
                      : lightTextColor,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: themeProvider.isDarkTheme ? darkBodyGradient : lightBodyGradient,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/profile_image.jpg'),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username, // Replace with the actual username
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Email: $email',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Account Settings',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.person, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Personal Information',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      Text(
                        '>',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(
                    thickness: 2, // Make the line between content bold
                  ),
                  const Row(
                    children: [
                      Icon(Icons.security, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Login & Security',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      Text(
                        '>',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(
                    thickness: 2, // Make the line between content bold
                  ),
                  const Row(
                    children: [
                      Icon(Icons.notifications, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Notification',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      Text(
                        '>',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(
                    thickness: 2, // Make the line between content bold
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Legal',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.description, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Terms of Services',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      Text(
                        '>',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(
                    thickness: 2, // Make the line between content bold
                  ),
                  const Row(
                    children: [
                      Icon(Icons.description, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Privacy Policy',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      Text(
                        '>',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(
                    thickness: 2, // Make the line between content bold
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 8),
                  Text(
                    'Version: $appVersion',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Align to the end of the Row
                    children: [
                      TextButton(
                        onPressed: () async {
                          // Remove user data from shared preferences
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.remove('username');
                          await prefs.remove('email');
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const SignupPage(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: themeProvider.isDarkTheme
                              ? const Color(0xFF231EAB)
                              : const Color(0xFF231EAB),
                        ),
                        child: const Text("Log Out"),
                      ),

                    ],
                  ),
                ],
              ),
              ),
    ])));
  }}
