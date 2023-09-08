import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeManager = ThemeManager();
  await themeManager._loadThemeMode(); // Load the theme mode before running the app

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignupModel()),
        ChangeNotifierProvider.value(value: themeManager),
      ],
      child: const MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: Provider.of<ThemeManager>(context).themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const SignupPage(),
    );
  }
}
class ThemeManager extends ChangeNotifier {
  late ThemeMode _themeMode;

  ThemeManager() {
    _loadThemeMode(); // Load saved theme mode from SharedPreferences
  }

  ThemeMode get themeMode => _themeMode;

  void toggleThemeMode() async {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await _saveThemeMode(); // Save the current theme mode to SharedPreferences
    notifyListeners();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString('theme_mode');
    _themeMode = themeModeString == 'dark' ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> _saveThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = _themeMode == ThemeMode.dark ? 'dark' : 'light';
    await prefs.setString('theme_mode', themeModeString);
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

class SignupSuccessPage extends StatelessWidget {
  const SignupSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup Successful"),
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

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signupModel = Provider.of<SignupModel>(context);
    final themeManager = Provider.of<ThemeManager>(context);


    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: signupModel.isDarkMode ? darkAppBarGradient : lightAppBarGradient,
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
                      gradient: signupModel.isDarkMode ? darkBackButtonGradient : lightBackButtonGradient,
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
                      themeManager.themeMode == ThemeMode.dark
                          ? Icons.light_mode
                          : Icons.dark_mode,
                      color: Colors.black,
                    ),
                    onPressed: signupModel.toggleDarkMode,
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
                  color: signupModel.isDarkMode ? Colors.black : Colors.black,
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
              gradient: signupModel.isDarkMode ? darkBodyGradient : lightBodyGradient,
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
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: signupModel.isDarkMode ? Colors.black : Colors.black),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Become a member and enjoy Cueprise services and benefits",
                        style: TextStyle(
                            fontSize: 16,
                            color: signupModel.isDarkMode ? Colors.black54 : Colors.black54),
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
                      _buildRoundedTextField(
                        signupModel.email,
                        "Email",
                        signupModel.isDarkMode,
                        onChanged: (value) => signupModel.email = value,
                        errorText: signupModel.emailError,
                      ),
                      const SizedBox(height: 16),
                      _buildRoundedTextField(
                        signupModel.phone,
                        "Phone Number",
                        signupModel.isDarkMode,
                        onChanged: (value) => signupModel.phone = value,
                        errorText: signupModel.phoneError,
                      ),
                      const SizedBox(height: 16),
                      _buildRoundedTextField(
                        signupModel.name,
                        "Name",
                        signupModel.isDarkMode,
                        onChanged: (value) => signupModel.name = value,
                        errorText: signupModel.nameError,
                      ),
                      const SizedBox(height: 16),
                      _buildRoundedTextFieldWithVisibility(
                        signupModel.password,
                        "Password",
                        signupModel.isDarkMode,
                        signupModel: signupModel,
                        onChanged: (value) => signupModel.password = value,
                        errorText: signupModel.passwordError,
                      ),
                      const SizedBox(height: 16),
                      if (signupModel.isLoading) ...[
                        const CircularProgressIndicator(),
                      ] else if (signupModel.signupError != null) ...[
                        Text(
                          signupModel.signupError!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      ] else ...[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: signupModel.isDarkMode
                                ? darkButtonGradient
                                : lightButtonGradient,
                            backgroundBlendMode: BlendMode.color,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              signupModel.signUp(context);
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
                      ],
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: signupModel.isDarkMode
                              ? darkButtonGradient
                              : lightButtonGradient,
                          backgroundBlendMode: BlendMode.color,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            signupModel.signUp(context);
                          },
                          style: commonButtonStyle,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Image.asset(
                                  'asset/google.png',
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
                                // Implement sign-in logic here
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: signupModel.isDarkMode
                                    ? const Color(0xFF231EAB)
                                    : const Color(0xFF231EAB),
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

  Widget _buildRoundedTextField(
      String value,
      String hint,
      bool isDarkMode, {
        bool obscureText = false,
        ValueChanged<String>? onChanged,
        String? errorText,
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
            onChanged: onChanged,
            obscureText: obscureText,
            style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              errorText: errorText,
              contentPadding: const EdgeInsets.all(10),
              hintStyle: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black45),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundedTextFieldWithVisibility(
      String value,
      String hint,
      bool isDarkMode, {
        SignupModel? signupModel,
        ValueChanged<String>? onChanged,
        String? errorText,
      }) {
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
            onChanged: onChanged,
            obscureText: signupModel?.obscureText ?? false,
            style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              errorText: errorText,
              contentPadding: const EdgeInsets.all(10),
              hintStyle: TextStyle(
                color: isDarkMode ? Colors.white70 : Colors.black45,
              ),
            ),
          ),
          GestureDetector(
            onTap: signupModel?.togglePasswordVisibility,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                signupModel?.obscureText ?? false ? Icons.visibility_off : Icons.visibility,
                color: isDarkMode ? Colors.white70 : Colors.black45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignupModel extends ChangeNotifier {
  String email = '';
  String phone = '';
  String name = '';
  String password = '';

  bool isDarkMode = false;
  bool obscureText = true;

  bool isLoading = false;
  String? emailError;
  String? phoneError;
  String? nameError;
  String? passwordError;
  String? signupError;
  void toggleDarkMode() async {
    isDarkMode = !isDarkMode;
    notifyListeners();

    // Persist the theme mode in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = isDarkMode ? 'dark' : 'light';
    await prefs.setString('theme_mode', themeModeString);
  }

  void togglePasswordVisibility() {
    obscureText = !obscureText;
    notifyListeners();
  }

  bool _validateEmail(String value) {
    if (value.isEmpty) {
      emailError = 'Email is required';
      return false;
    } else if (!value.contains('@')) {
      emailError = 'Invalid email address';
      return false;
    }
    emailError = null;
    return true;
  }

  bool _validatePhone(String value) {
    if (value.isEmpty) {
      phoneError = 'Phone number is required';
      return false;
    }
    phoneError = null;
    return true;
  }

  bool _validateName(String value) {
    if (value.isEmpty) {
      nameError = 'Name is required';
      return false;
    }
    nameError = null;
    return true;
  }

  bool _validatePassword(String value) {
    if (value.isEmpty) {
      passwordError = 'Password is required';
      return false;
    }
    passwordError = null;
    return true;
  }

  Future<void> signUp(BuildContext context) async {
    final scaffoldContext = ScaffoldMessenger.of(context);

    try {
      isLoading = true;
      signupError = null;
      notifyListeners();

      // Validate all fields
      final isEmailValid = _validateEmail(email);
      final isPhoneValid = _validatePhone(phone);
      final isNameValid = _validateName(name);
      final isPasswordValid = _validatePassword(password);

      if (!isEmailValid || !isPhoneValid || !isNameValid || !isPasswordValid) {
        isLoading = false;
        notifyListeners();
        return;
      }

      await _performSignUp();

      scaffoldContext.showSnackBar(
        const SnackBar(
          content: Text('Signup successful!'),
        ),
      );

      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.of(scaffoldContext as BuildContext).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const SignupSuccessPage(),
          ),
        );
      });
    } catch (error) {
      signupError = error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _performSignUp() async {
    // Simulate a delay to mimic an API call.
    await Future.delayed(const Duration(seconds: 3));

    if (email.isEmpty || password.isEmpty) {
      throw 'Email and password are required.';
    }
  }
}

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

