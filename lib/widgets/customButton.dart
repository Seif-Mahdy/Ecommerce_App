import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;

  const CustomButton({Key key, this.gradient, this.width, this.height, this.onPressed, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(gradient: gradient,
      borderRadius: BorderRadius.circular(28)),
      child: Material(
        borderRadius: BorderRadius.circular(28),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
