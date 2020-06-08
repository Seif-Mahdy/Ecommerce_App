import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final Widget icon;
  final Function onClick;
  const CustomTextField({Key key, this.hint, this.icon, this.onClick}) : super(key: key);
  // ignore: missing_return
  String _errorMessage(String str) {
   if(hint.toLowerCase().contains('email'))
     {
       return 'Email can\'t be empty';
     }
   else if(hint.toLowerCase().contains('password'))
     {
       return 'Password can\'t be empty';
     }
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // ignore: missing_return
      validator:(value)
      {
        if(value.isEmpty)
          {
            return _errorMessage(value);
          }
      },
      onSaved: onClick,
      obscureText: hint.toLowerCase().contains('password')? true : false,
      cursorColor: Color.fromARGB(100, 227, 73, 124),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: icon,
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: Colors.white)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: Colors.white)),
      ),
    );
  }
}
