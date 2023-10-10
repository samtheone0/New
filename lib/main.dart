import 'package:App/Signup_page/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:App/Signup_page/theme_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Homepage/homepage.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => FormProvider()),
      ],
      child: const MyApp(), // Replace MyApp with your MaterialApp widget
    ),
  );
  SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: []);
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Use FutureBuilder to fetch data from SharedPreferences asynchronously
    return FutureBuilder(
      future: _getUserDataFromSharedPreferences(),
      builder: (context, snapshot) {
        Widget initialRoute;

        if (snapshot.connectionState == ConnectionState.done) {
          final username = snapshot.data?['username'];
          final email = snapshot.data?['email'];

          if (username != null && email != null) {
            // User data exists, navigate to HomePage
            initialRoute = HomePage(username: username, email: email, appVersion: '');
          } else {
            // User data doesn't exist, navigate to SignupPage
            initialRoute = const SignupPage();
          }
        } else {
          // Show a loading indicator or some other widget while fetching data
          initialRoute = const CircularProgressIndicator();
        }

        return MaterialApp(
          title: 'Flutter Dark Theme',
          theme: themeProvider.themeData,
          home: initialRoute,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }

  Future<Map<String, String?>> _getUserDataFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final email = prefs.getString('email');

    return {'username': username, 'email': email};
  }
}

