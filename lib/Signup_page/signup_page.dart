import 'package:App/Homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dark_theme.dart';
import 'light_theme.dart';
import 'theme_manager.dart';
class FormModel {
  String email = '';
  String phoneNumber = '';
  String name = '';
  String password = '';
  bool isValid = false;
  String error = '';

  void resetError() {
    error = '';
  }
}

class FormProvider with ChangeNotifier {
  final FormModel _formData = FormModel();

  FormModel get formData => _formData;

  void validateForm() {
    _formData.isValid = _formData.email.isNotEmpty &&
        _formData.phoneNumber.isNotEmpty &&
        _formData.name.isNotEmpty &&
        _formData.password.isNotEmpty;

    if (!_formData.isValid) {
      _formData.error = 'Please fill in all fields.';
    } else if (!_isValidEmail(_formData.email)) {
      _formData.error = 'Invalid email address.';
    } else if (!_isValidPhoneNumber(_formData.phoneNumber)) {
      _formData.error = 'Invalid phone number.';
    } else {
      _formData.error = '';
    }

    notifyListeners();
  }

  bool _isValidEmail(String email) {
    return email.contains('@') && email.contains('.');
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    return RegExp(r'^[0-9+]+$').hasMatch(phoneNumber);
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final formProvider = Provider.of<FormProvider>(context);

    Color darkTextColor = Colors.black;
    Color lightTextColor = Colors.black;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  color: themeProvider.isDarkTheme ? darkTextColor : lightTextColor,
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
              gradient:
              themeProvider.isDarkTheme ? darkBodyGradient : lightBodyGradient,
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
                            color: themeProvider.isDarkTheme
                                ? darkTextColor
                                : lightTextColor),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Become a member and enjoy Cueprise services and benefits",
                        style: TextStyle(
                            fontSize: 16,
                            color: themeProvider.isDarkTheme ? darkTextColor : lightTextColor),
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
                        "Email",
                        themeProvider.isDarkTheme,
                        onChanged: (value) {
                          formProvider.formData.email = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildRoundedTextField(
                        "Phone Number",
                        themeProvider.isDarkTheme,
                        onChanged: (value) {
                          formProvider.formData.phoneNumber = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildRoundedTextField(
                        "Name",
                        themeProvider.isDarkTheme,
                        onChanged: (value) {
                          formProvider.formData.name = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildRoundedTextFieldWithVisibility(
                        "Password",
                        themeProvider.isDarkTheme,
                        onChanged: (value) {
                          formProvider.formData.password = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: themeProvider.isDarkTheme
                              ? darkButtonGradient
                              : lightButtonGradient,
                          backgroundBlendMode: BlendMode.color,
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            formProvider.validateForm();
                            if (formProvider.formData.isValid) {
                              setState(() {
                                isLoading = true;
                              });

                              final dialogContext = context;

                              await Future.delayed(const Duration(seconds: 3));

                              if (formProvider._isValidEmail(formProvider.formData.email) &&
                                  formProvider._isValidPhoneNumber(formProvider.formData.phoneNumber)) {
                                // Save user data to SharedPreferences
                                final prefs = await SharedPreferences.getInstance();
                                prefs.setString('username', formProvider.formData.name);
                                prefs.setString('email', formProvider.formData.email);

                                // Navigate to the profile screen with username and email
                                Navigator.of(dialogContext).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (_) => HomePage(
                                      username: formProvider.formData.name,
                                      email: formProvider.formData.email,
                                      appVersion: '',
                                    ),
                                  ),
                                );
                              } else {
                                // Display an error message for 2 seconds
                                showDialog(
                                  context: dialogContext,
                                  builder: (BuildContext context) {
                                    return const AlertDialog(
                                      title: Text('Error'),
                                      content: Text(
                                        'Invalid phone number or email address. Please check and try again.',
                                      ),
                                    );
                                  },
                                );

                                Future.delayed(const Duration(seconds: 2), () {
                                  Navigator.of(dialogContext).pop();
                                });
                              }

                              setState(() {
                                isLoading = false;
                              });
                            }
                            else {
                              // Display an error message for 2 seconds
                              showDialog(
                                context: context, // Use the captured context here
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Error'),
                                    content: Text(formProvider.formData.error),
                                  );
                                },
                              );

                              Future.delayed(const Duration(seconds: 2), () {
                                Navigator.of(context).pop(); // Close the dialog after 2 seconds
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
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
                          gradient: themeProvider.isDarkTheme
                              ? darkButtonGradient
                              : lightButtonGradient,
                          backgroundBlendMode: BlendMode.color,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // Implement "Sign Up with Google" logic
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
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
                                // Implement "Sign In" button logic here
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: themeProvider.isDarkTheme
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
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget _buildRoundedTextField(
      String hint,
      bool isDarkMode, {
        bool obscureText = false,
        ValueChanged<String>? onChanged,
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
              contentPadding: const EdgeInsets.all(10),
              hintStyle:
              TextStyle(color: isDarkMode ? Colors.white70 : Colors.black45),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundedTextFieldWithVisibility(
      String hint,
      bool isDarkMode, {
        ValueChanged<String>? onChanged,
      }) {
    return PasswordField(
      hint: hint,
      isDarkMode: isDarkMode,
      onChanged: onChanged,
    );
  }
}

class PasswordField extends StatefulWidget {
  final String hint;
  final bool isDarkMode;
  final ValueChanged<String>? onChanged;

  const PasswordField({
    Key? key,
    required this.hint,
    required this.isDarkMode,
    this.onChanged,
  }) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: widget.isDarkMode ? darkInputFieldGradient : lightInputFieldGradient,
        backgroundBlendMode: BlendMode.colorBurn,
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          TextField(
            onChanged: widget.onChanged,
            obscureText: obscureText,
            style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hint,
              contentPadding: const EdgeInsets.all(10),
              hintStyle: TextStyle(
                color: widget.isDarkMode ? Colors.white70 : Colors.black45,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                // Toggle password visibility
                obscureText = !obscureText;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: widget.isDarkMode ? Colors.white70 : Colors.black45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
