import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'otp_screen.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}
class _RegistrationPageState extends State<RegistrationPage> {


  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final locationController = TextEditingController();


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
        child:  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8),

                const Text(
                  "Profile Photo",
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
                SizedBox(height: 15),

                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 6),
                        labelText: "Name",
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),

                Card(
                    elevation: 5,

                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                      child: TextField(
                        controller: mobileController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 6),
                          labelText: "Mobile Number",
                          prefixIcon: Icon(Icons.phone),
                          ),
                        ),
                      ),
                    ),



                SizedBox(height: 12),

                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 6),
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),

                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 6),
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),

                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),

                Card(
                  elevation: 5,

                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                    child: TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 6),
                        labelText: "Confirm Password",
                        prefixIcon: Icon(Icons.lock_outline),

                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),

                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                    child: TextField(
                      controller: locationController,
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 6),
                        labelText: "Location",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: Icon(Icons.location_on),

                      ),
                    ),
                  ),
                ),

                SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child:ElevatedButton(
                    onPressed: () async {

                      if (nameController.text.isEmpty ||
                          mobileController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          passwordController.text.isEmpty ||
                          confirmPasswordController.text.isEmpty ||
                          locationController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please fill all fields")),
                        );
                        return;
                      }

                      try {
                        String phone = mobileController.text.trim();

                        await FirebaseFirestore.instance.collection('users').add({
                          'name': nameController.text.trim(),
                          'mobile': mobileController.text.trim(),
                          'email': emailController.text.trim(),
                          'password': passwordController.text.trim(),
                          'location': locationController.text.trim(),
                          'role': "corporate",
                          'createdAt': Timestamp.now(),
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Registration Successful!")),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpScreen(
                              mobileNumber: phone,
                            ),
                          ),
                        );
                        nameController.clear();
                        mobileController.clear();
                        emailController.clear();
                        passwordController.clear();
                        confirmPasswordController.clear();
                        locationController.clear();

                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error: $e")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Color(0xFFBE0108),
                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(fontSize: 18, color: Colors.white),

                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),

      ),

    );
  }
}


