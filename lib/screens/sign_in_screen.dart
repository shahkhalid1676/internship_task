import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dashboard_screen.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Email TextField
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16),

            // Password TextField
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),

            // Sign In Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                String email = emailController.text.trim();
                String password = passwordController.text.trim();

                if (email.isEmpty || password.isEmpty) {
                  Get.snackbar("Error", "Please fill all fields",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white);
                  return;
                }

                // Show loading indicator
                EasyLoading.show(status: 'Signing In...');

                try {
                  // Sign In using Firebase Authentication
                  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );

                  // Save session in SharedPreferences
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('isLoggedIn', true);

                  // Navigate to Dashboard screen
                  EasyLoading.dismiss(); // Dismiss loading indicator
                  Get.offAll(() => DashboardScreen());
                } catch (e) {
                  EasyLoading.dismiss(); // Dismiss loading indicator
                  Get.snackbar("Error", "Invalid email or password",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white);
                }
              },
              child: Text(
                "Sign In",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),

            SizedBox(height: 20),

            // Navigate to Sign Up screen
            GestureDetector(
              onTap: () {
                Get.to(() => SignUpScreen());
              },
              child: Text(
                "Don't have an account? Sign Up",
                style: TextStyle(fontSize: 16, color: Colors.teal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
