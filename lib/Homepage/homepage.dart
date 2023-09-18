import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../Homepage/meme.dart';
import '../Profile/profile_screen.dart';
import '../Signup_page/dark_theme.dart';
import '../Signup_page/light_theme.dart';
import '../Signup_page/theme_manager.dart';

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

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<Meme> memes = [];
  var index = 0;
  late AnimationController _titleAnimController;
  late AnimationController _memeAnimController;

  @override
  void initState() {
    super.initState();
    _titleAnimController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _memeAnimController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    fetchMemes().then((data) => {
      setState(() {
        memes = data;
      })
    });
  }

  @override
  void dispose() {
    _titleAnimController.dispose();
    _memeAnimController.dispose();
    super.dispose();
  }

  Future<List<Meme>> fetchMemes() async {
    var url = await http.get(Uri.parse("https://api.imgflip.com/get_memes"));
    if (url.statusCode == 200) {
      final fetchedItems = json.decode(url.body);
      List<Meme> memes = [];
      for (var memeItem in fetchedItems['data']['memes']) {
        Meme item = Meme.fromJson(memeItem);
        memes.add(item);
      }
      return memes;
    } else {
      throw Exception('Failed to load items');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (memes.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final themeProvider = Provider.of<ThemeProvider>(context);
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

    return Scaffold(
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
                        // Implement back button logic here
                      },
                      style: customButtonStyle(context, themeProvider.isDarkTheme),
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
                      Icons.person, // Use your profile icon here
                      color: themeProvider.isDarkTheme
                          ? darkTextColor
                          : lightTextColor,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient:
              themeProvider.isDarkTheme ? darkBodyGradient : lightBodyGradient,
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _memeAnimController,
              builder: (context, child) {
                final screenWidth = MediaQuery.of(context).size.width;
                final startOffset = index > index ? screenWidth : -screenWidth;
                const endOffset = 0;

                final offset =
                    lerpDouble(startOffset, endOffset, _memeAnimController.value) ?? 0.0;

                return Transform.translate(
                  offset: Offset(offset, 0),
                  child: Center(
                    child: child,
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    memes[index].name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Image.network(
                    memes[index].url,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (index == 0) {
                        // ...
                      } else {
                        setState(() {
                          index--;
                          _memeAnimController.reset();
                          _memeAnimController.forward();
                        });
                      }
                    },
                    style: customButtonStyle(context, themeProvider.isDarkTheme),
                    child: Icon(
                      Icons.arrow_back_ios_new_sharp,
                      color: themeProvider.isDarkTheme ? Colors.grey : Colors.grey,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (index < memes.length - 1) {
                        setState(() {
                          index++;
                          _memeAnimController.reset();
                          _memeAnimController.forward();
                        });
                      } else {
                        // You've reached the end of the list.
                        // Handle it as per your requirements.
                      }
                    },
                    style: customButtonStyle(context, themeProvider.isDarkTheme),
                    child: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: themeProvider.isDarkTheme ? Colors.grey : Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
