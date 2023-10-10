import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../Profile/profile_screen.dart';
import '../Signup_page/dark_theme.dart';
import '../Signup_page/light_theme.dart';
import '../Signup_page/theme_manager.dart';
import 'fetch.dart';
import 'product_detail.dart';

class HomePage extends StatefulWidget {
  final String username;
  final String email;
  final String appVersion;

  const HomePage({
    Key? key,
    required this.username,
    required this.email,
    required this.appVersion,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [];
  late ThemeProvider themeProvider; // Declare themeProvider here

  @override
  void initState() {
    super.initState();
    fetchProducts().then((data) {
      setState(() {
        products = data;
      });
    });
  }

  Future<List<Product>> fetchProducts() async {
    var url = Uri.parse("https://fakestoreapi.com/products");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Product> productList = data.map((item) {
        return Product(
          id: item['id'],
          title: item['title'],
          description: item['description'],
          price: item['price'].toDouble(),
          image: item['image'],
        );
      }).toList();
      return productList;
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Rest of your code...

  @override
  Widget build(BuildContext context) {
    themeProvider =
        Provider.of<ThemeProvider>(context); // Initialize themeProvider here

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: themeProvider.isDarkTheme
                ? darkAppBarGradient
                : lightAppBarGradient,
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
                        // Implement back button logic here
                      },
                      style:
                      customButtonStyle(context, themeProvider.isDarkTheme),
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
                  IconButton(
                    icon: Icon(
                      Icons.person,
                      color: themeProvider.isDarkTheme
                          ? darkTextColor
                          : lightTextColor,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProfileScreen(
                                username: widget.username,
                                email: widget.email,
                                appVersion: widget.appVersion,
                                navigateToLoginScreen: (BuildContext context) {
                                  // Define the logic to navigate to the login screen here
                                },
                              ),
                        ),
                      );
                    },
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
      resizeToAvoidBottomInset: false,
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.title),
            subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
            leading: Image.network(product.image),
            onTap: () {
              // Navigate to product details screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailsScreen(product: product, username: '', email: '', appVersion: '',),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
