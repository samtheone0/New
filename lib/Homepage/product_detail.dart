import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../Signup_page/dark_theme.dart';
import '../Signup_page/light_theme.dart';
import '../Signup_page/theme_manager.dart';
import 'fetch.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  final String username;
  final String email;
  final String appVersion;

  const ProductDetailsScreen({
    Key? key,
    required this.product,
    required this.username,
    required this.email,
    required this.appVersion,
  }) : super(key: key);

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
            automaticallyImplyLeading: false,
            systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
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
                      gradient: themeProvider.isDarkTheme ? darkBackButtonGradient : lightBackButtonGradient,
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
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(product.image),

              Text(product.title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              Text("\$${product.price.toStringAsFixed(2)}", style: TextStyle(fontSize: 18.0)),

              Text(
                product.description,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
