import 'package:ecommerceapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class SplashScreen extends StatelessWidget {
  static String id = 'SplashScreen';
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: backGroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height*0.25,
            width: MediaQuery.of(context).size.width*0.54,
            child: Image.asset('assets/images/logo.png'),
          ),
          SizedBox(
            height: 20,
          ),
          SvgPicture.asset(
            'assets/svg/text.svg',
            height: 27.429401397705078,
            width: 316.2769470214844,
          ),
        ],
      ),
    );
  }
}
