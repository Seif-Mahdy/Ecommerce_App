import 'package:ecommerceapp/pages/login.dart';
import 'package:ecommerceapp/pages/signup.dart';
import 'package:ecommerceapp/pages/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-commerce App',
      initialRoute: SignUpPage.id,
      routes:{
        SplashScreen.id: (context) => SplashScreen(),
        SignUpPage.id: (context) => SignUpPage(),
        LoginPage.id: (context) => LoginPage(),
        SignUpPage.id: (context) => SignUpPage(),
      },
    );
  }
}
