import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

          return Theme(
            data: isDarkMode ? darkTheme : lightTheme,
            child: const SignupPage(),
          );
        },
      ),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isDarkMode = false;
  bool obscureText = true; // Password is initially hidden

  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
      setState(() {
        this.isDarkMode = isDarkMode;
      });
    });
  }

  Widget _buildRoundedTextField(
      TextEditingController controller,
      String hint,
      bool isDarkMode, {
        bool obscureText = false,
      }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: isDarkMode ? darkInputFieldGradient : lightInputFieldGradient,
        backgroundBlendMode: BlendMode.colorBurn,
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          TextField(
            controller: controller,
            obscureText: obscureText,
            style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              contentPadding: const EdgeInsets.all(10),
              hintStyle: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black45),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundedTextFieldWithVisibility(
      TextEditingController controller,
      String hint,
      bool isDarkMode,
      ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: isDarkMode ? darkInputFieldGradient : lightInputFieldGradient,
        backgroundBlendMode: BlendMode.colorBurn,
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          TextField(
            controller: controller,
            obscureText: obscureText,
            style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              contentPadding: const EdgeInsets.all(10),
              hintStyle: TextStyle(
                color: isDarkMode ? Colors.white70 : Colors.black45,
              ),
            ),
          ),
          GestureDetector(
            onTap: togglePasswordVisibility,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: isDarkMode ? Colors.white70 : Colors.black45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: isDarkMode ? darkAppBarGradient : lightAppBarGradient,
          ),
          child: AppBar(
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
                      gradient: isDarkMode ? darkBackButtonGradient : lightBackButtonGradient,
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
                      isDarkMode ? Icons.light_mode : Icons.dark_mode,
                      color: Colors.black,
                    ),
                    onPressed: toggleDarkMode,
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
                  color: isDarkMode ? Colors.black : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: isDarkMode ? darkBodyGradient : lightBodyGradient,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Account Sign-up",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.black : Colors.black),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Become a member and enjoy Cueprise services and benefits",
                        style: TextStyle(fontSize: 16, color: isDarkMode ? Colors.black54 : Colors.black54),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildRoundedTextField(_emailController, "Email", isDarkMode),
                      const SizedBox(height: 16),
                      _buildRoundedTextField(_phoneController, "Phone Number", isDarkMode),
                      const SizedBox(height: 16),
                      _buildRoundedTextField(_nameController, "Name", isDarkMode),
                      const SizedBox(height: 16),
                      _buildRoundedTextFieldWithVisibility(_passwordController, "Password", isDarkMode),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: isDarkMode ? darkButtonGradient : lightButtonGradient,
                          backgroundBlendMode: BlendMode.color,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // Perform sign-up logic here
                          },
                          style: commonButtonStyle,
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: isDarkMode ? darkButtonGradient : lightButtonGradient,
                          backgroundBlendMode: BlendMode.color,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // Perform sign-up with Google logic here
                          },
                          style: commonButtonStyle,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Image.asset(
                                  'asset/google.png', // Corrected the asset path
                                  width: 30,
                                  height: 20,
                                ),
                              ),
                              const Text(
                                "Sign Up with Google",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        margin: const EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Implement sign-in navigation logic here
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: isDarkMode ? const Color(0xFF231EAB) : const Color(0xFF231EAB),
                              ),
                              child: const Text("Sign In"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final commonButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.transparent,
  elevation: 0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
    side: const BorderSide(
      color: Color(0xFF03193D),
    ),
  ),
);

const lightAppBarGradient = LinearGradient(
  colors: [Color(0xFFF0E29E), Color(0xFFDFD9C6)],
  begin: Alignment.topLeft,
  end: Alignment.topLeft,
);

const darkAppBarGradient = LinearGradient(
  colors: [Colors.black, Colors.grey],
  begin: Alignment.topLeft,
  end: Alignment.topLeft,
);

const lightBodyGradient = LinearGradient(
  colors: [Color(0xFFF0E29E), Color(0xFFDFD9C6)],
  begin: Alignment.topLeft,
  end: Alignment.topLeft,
);

const darkBodyGradient = LinearGradient(
  colors: [Colors.black, Colors.grey],
  begin: Alignment.topLeft,
  end: Alignment.topLeft,
);

const lightInputFieldGradient = LinearGradient(
  colors: [Colors.white, Colors.grey],
  begin: Alignment.bottomRight,
  end: Alignment.bottomRight,
);

const darkInputFieldGradient = LinearGradient(
  colors: [Colors.black, Colors.grey],
  begin: Alignment.bottomRight,
  end: Alignment.bottomRight,
);

const lightButtonGradient = LinearGradient(
  colors: [Color(0xFFF0E29E), Color(0xFFDFD9C6)],
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

const lightBackButtonGradient = LinearGradient(
  colors: [Color(0xFFF0E29E), Color(0xFFDFD9C6)],
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

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFFF0E29E),
  colorScheme: const ColorScheme.light(
    background: Color(0xFFF0E29E),
  ),
);
