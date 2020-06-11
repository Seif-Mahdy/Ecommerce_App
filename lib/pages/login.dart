import 'package:ecommerceapp/pages/adminControleCenter.dart';
import 'package:ecommerceapp/pages/signup.dart';
import 'package:ecommerceapp/providers/adminMode.dart';
import 'package:ecommerceapp/providers/modalHud.dart';
import 'package:ecommerceapp/services/auth.dart';
import 'package:ecommerceapp/widgets/customButton.dart';
import 'package:ecommerceapp/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'homeScreen.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  static String id = 'LoginPage';
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String _email, _password;
  final _auth = Auth();
  final adminPassword = 'admin123456';

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Provider.of<ModalHud>(context).isLoading,
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 120),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.54,
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: Image.asset('assets/images/logo.png'),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Form(
                            key: globalKey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: <Widget>[
                                  CustomTextField(
                                    hint: 'Enter Your Email',
                                    icon: Image.asset(
                                      'assets/svg/mail.png',
                                      scale: 1.4,
                                    ),
                                    onClick: (value) {
                                      _email = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextField(
                                    hint: 'Enter Your Password',
                                    icon: Image.asset(
                                      'assets/svg/password.png',
                                      scale: 1.4,
                                    ),
                                    onClick: (value) {
                                      _password = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Builder(
                                    builder: (context) => CustomButton(
                                      width: 156,
                                      height: 57,
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        _validate(context);
                                      },
                                      gradient: LinearGradient(
                                        colors: <Color>[
                                          Color.fromARGB(1000, 72, 93, 242),
                                          Color.fromARGB(1000, 227, 73, 124)
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Don\'t have an account?',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          ' Sign Up',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  227, 73, 124, 1),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      createAdminUserText(
                                          Provider.of<AdminMode>(context)
                                              .isAdmin,
                                          context),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _validate(BuildContext context) async{
    final modalHud = Provider.of<ModalHud>(context,listen: false);
    modalHud.changeIsLoading(true);
    if (globalKey.currentState.validate()) {
      globalKey.currentState.save();
      if (Provider.of<AdminMode>(context,listen: false).isAdmin) {
        if (_password == adminPassword) {
          try {
            await _auth.login(_email, _password);
            modalHud.changeIsLoading(false);
            Navigator.pushNamed(context, AdminControlCenter.id);
          } catch (e) {
            modalHud.changeIsLoading(false);
            Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Color.fromRGBO(255, 255, 255, 0.2),
              content: Text(
                e.message,
                style: TextStyle(
                    color: Color.fromRGBO(227, 73, 124, 1),
                    fontWeight: FontWeight.bold),
              ),
            ));
          }
        } else {
          modalHud.changeIsLoading(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.2),
            content: Text(
              "Incorrect Password",
              style: TextStyle(
                  color: Color.fromRGBO(227, 73, 124, 1),
                  fontWeight: FontWeight.bold),
            ),
          ));
        }
      } else {
        try {
          final authResult = await _auth.login(_email.trim(), _password.trim());
          modalHud.changeIsLoading(false);
          Navigator.pushNamed(context, HomeScreen.id);
        } catch (e) {

          modalHud.changeIsLoading(false);

          Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.2),
            content: Text(
              e.message,
              style: TextStyle(
                  color: Color.fromRGBO(227, 73, 124, 1),
                  fontWeight: FontWeight.bold),
            ),
          ));
        }
      }
    }
    modalHud.changeIsLoading(false);
  }
}

Widget createAdminUserText(bool isAdmin, BuildContext context) {
  if (!isAdmin) {
    return InkWell(
      onTap: () {
        final adminMode = Provider.of<AdminMode>(context, listen: false);
        adminMode.changeIsAdmin(true);
      },
      child: Text(
        'I\'m an admin',
        style: TextStyle(
            color: Color.fromRGBO(72, 93, 242, 1), fontWeight: FontWeight.bold),
      ),
    );
  } else
    return InkWell(
      onTap: () {
        final adminMode = Provider.of<AdminMode>(context, listen: false);
        adminMode.changeIsAdmin(false);
      },
      child: Text(
        'I\'m a user',
        style: TextStyle(
            color: Color.fromRGBO(72, 93, 242, 1), fontWeight: FontWeight.bold),
      ),
    );
}
