import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'otp_screen.dart';
import 'login_page.dart';


class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String? _mobileError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _locationError;

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final locationController = TextEditingController();

  void _validateRegistration() {
    setState(() {
      _mobileError = null;
      _passwordError = null;
      _confirmPasswordError = null;
      _locationError = null;

      String mobile = mobileController.text.trim();
      String password = passwordController.text.trim();
      String confirmPassword = confirmPasswordController.text.trim();
      String location = locationController.text.trim();

      if (mobile.isEmpty) {
        _mobileError = "Mobile number is required.";
      } else if (mobile.length != 10 ||
          !RegExp(r'^[0-9]+$').hasMatch(mobile)) {
        _mobileError = "Enter valid 10-digit mobile number.";
      }

      if (password.isEmpty) {
        _passwordError = "Password is required.";
      } else if (password.length < 8) {
        _passwordError = "Password must be at least 8 characters.";
      } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&]).+$')
          .hasMatch(password)) {
        _passwordError =
        "Password must include letter, number & special symbol.";
      }

      if (confirmPassword.isEmpty) {
        _confirmPasswordError = "Confirm your password.";
      } else if (confirmPassword != password) {
        _confirmPasswordError = "Passwords do not match.";
      }

      if (location.isEmpty) {
        _locationError = "Location is required.";
      } else if (!RegExp(r'^[A-Z]').hasMatch(location)) {
        _locationError = "Location must start with capital letter.";
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgroundimage.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const SizedBox(height: 8),

                const Text(
                  "Registration ",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                Center(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Name",
                    prefixIcon: const Icon(Icons.person, color: Color(0xFF0F5272)),
                    filled: true,
                    fillColor: const Color(0xFFEFEFEF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Mobile Number",
                    prefixIcon: const Icon(Icons.phone, color: Color(0xFF0F5272)),
                    filled: true,
                    fillColor: const Color(0xFFEFEFEF),
                    errorText: _mobileError,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: const Icon(Icons.email, color: Color(0xFF0F5272)),
                    filled: true,
                    fillColor: const Color(0xFFEFEFEF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.lock, color: Color(0xFF0F5272)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    filled: true,
                    fillColor: const Color(0xFFEFEFEF),
                    errorText: _passwordError,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    prefixIcon: const Icon(Icons.lock, color: Color(0xFF0F5272)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                          !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                    filled: true,
                    fillColor: const Color(0xFFEFEFEF),
                    errorText: _confirmPasswordError,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: locationController,
                  decoration: InputDecoration(
                    hintText: "Location",
                    prefixIcon: const Icon(Icons.location_on, color: Color(0xFF0F5272)),
                    filled: true,
                    fillColor: const Color(0xFFEFEFEF),
                    errorText: _locationError,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () async {

                      _validateRegistration();

                      if (_mobileError != null ||
                          _passwordError != null ||
                          _confirmPasswordError != null ||
                          _locationError != null) {
                        return;
                      }

                      String phone = mobileController.text.trim();

                      var existingUser = await FirebaseFirestore.instance
                          .collection('users')
                          .where('mobile', isEqualTo: phone)
                          .get();

                      if (existingUser.docs.isNotEmpty) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      } else {
                        await FirebaseFirestore.instance.collection('users').add({
                          'name': nameController.text.trim(),
                          'mobile': phone,
                          'email': emailController.text.trim(),
                          'password': passwordController.text.trim(),
                          'location': locationController.text.trim(),
                          'role': "corporate",
                          'createdAt': Timestamp.now(),
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpScreen(
                              mobileNumber: phone,
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      backgroundColor: const Color(0xFFBE0108),
                    ),
                    child: const Text(
                      "Register Now",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}