import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'screens/sign_in_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Code Miners Internship Task',
      theme: ThemeData(primarySwatch: Colors.teal),
      builder: EasyLoading.init(),
      home: FutureBuilder(
        future: _checkIfLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {

            EasyLoading.show(status: 'Checking Login Status...');
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }


          EasyLoading.dismiss();

          if (snapshot.hasData && snapshot.data == true) {
            return DashboardScreen();
          }

          return SignInScreen();
        },
      ),
      routes: {
        '/signup': (context) => SignUpScreen(),
        '/signin': (context) => SignInScreen(),
        '/dashboard': (context) => DashboardScreen(),
      },
    );
  }

  Future<bool> _checkIfLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return isLoggedIn;
  }
}
