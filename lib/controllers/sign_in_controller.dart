import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  var isPasswordVisible = false.obs;

  Future<UserCredential?> signInMethod(String email, String password) async {
    try {
      EasyLoading.show(status: "Logging in...");
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      EasyLoading.dismiss();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Error", e.message ?? "Login failed");
      return null;
    }
  }
}
