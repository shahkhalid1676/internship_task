import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Username TextField
            TextField(
              controller: userNameController,
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16),

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

            // Sign Up Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                String username = userNameController.text.trim();
                String email = emailController.text.trim();
                String password = passwordController.text.trim();

                // Validate input fields
                if (username.isEmpty || email.isEmpty || password.isEmpty) {
                  Get.snackbar("Error", "Please fill all fields",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white);
                  return;
                }

                // Show loading indicator
                EasyLoading.show(status: 'Signing Up...');

                try {
                  // Sign Up using Firebase Authentication
                  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );

                  // Save user session
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('isLoggedIn', true);

                  EasyLoading.dismiss(); // Dismiss loading indicator
                  Get.snackbar("Success", "Account created successfully!",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.teal,
                      colorText: Colors.white);

                  // Navigate to Sign In screen
                  Get.offAll(() => SignInScreen());
                } catch (e) {
                  EasyLoading.dismiss(); // Dismiss loading indicator
                  Get.snackbar("Error", "Sign up failed. Try again.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white);
                }
              },
              child: Text(
                "Sign Up",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),

            SizedBox(height: 20),

            // Navigate to Sign In screen
            GestureDetector(
              onTap: () {
                Get.to(() => SignInScreen());
              },
              child: Text(
                "Already have an account? Sign In",
                style: TextStyle(fontSize: 16, color: Colors.teal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
