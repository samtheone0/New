import 'package:App/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:App/theme_manager.dart';
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
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Flutter Dark Theme',
      theme: themeProvider.themeData,
      home: const SignupPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
