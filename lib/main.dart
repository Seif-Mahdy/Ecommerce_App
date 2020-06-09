import 'package:ecommerceapp/pages/adminControleCenter.dart';
import 'package:ecommerceapp/pages/homeScreen.dart';
import 'package:ecommerceapp/pages/login.dart';
import 'package:ecommerceapp/pages/signup.dart';
import 'package:ecommerceapp/pages/splash_screen.dart';
import 'package:ecommerceapp/providers/adminMode.dart';
import 'package:ecommerceapp/providers/modalHud.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider<ModalHud>(create: (context)=>ModalHud(),),
        ChangeNotifierProvider<AdminMode>(create: (context)=>AdminMode(),),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'E-commerce App',
          initialRoute: SignUpPage.id,
          routes:{
            SplashScreen.id: (context) => SplashScreen(),
            SignUpPage.id: (context) => SignUpPage(),
            LoginPage.id: (context) => LoginPage(),
            SignUpPage.id: (context) => SignUpPage(),
            AdminControlCenter.id: (context) =>AdminControlCenter(),
            HomeScreen.id: (context) => HomeScreen(),
          },
      ),
    );
  }
}

