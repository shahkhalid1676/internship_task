import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sign_in_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {

            try {

              await FirebaseAuth.instance.signOut();


              final prefs = await SharedPreferences.getInstance();
              prefs.remove('isLoggedIn');


              Get.snackbar("Logout", "You have been logged out.",
                  snackPosition: SnackPosition.BOTTOM);


              Get.offAll(() => SignInScreen());
            } catch (e) {

              Get.snackbar("Error", "An error occurred during logout.",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white);
            }
          },
          child: Text("Logout"),
        ),
      ),
    );
  }
}
