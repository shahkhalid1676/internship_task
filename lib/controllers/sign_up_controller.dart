import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SignUpController extends GetxController {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<bool> signUpMethod(String username, String email, String password) async {
    try {

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );


      await userCredential.user?.sendEmailVerification();


      return true;
    } catch (e) {

      if (e is FirebaseAuthException) {

        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        } else if (e.code == 'invalid-email') {
          print('The email is invalid.');
        }
      } else {
        print('An unknown error occurred: $e');
      }
      return false;
    }
  }


  Future<void> signOut() async {
    await _auth.signOut();
  }
}
