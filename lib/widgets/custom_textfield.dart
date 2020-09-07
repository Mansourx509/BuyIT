import 'package:flutter/material.dart';
import 'package:buyit/constants.dart';

class CustomTextField extends StatelessWidget {

  final String hint;
  final IconData icon;
  final Function onClick;
  CustomTextField({@required this.onClick , @required this.icon , @required this.hint});



  String _errorMessages(String str){
    switch(hint){
      case 'Enter Your Name' : return 'Name is Empty !';
      case 'Enter Your Email' : return 'Email is Empty !';
      case 'Enter Your Password' : return 'Password is Empty !';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal : 20),
      child: TextFormField(
        validator: (value){
          if(value.isEmpty){
            return _errorMessages(hint);
          }else{
            // ignore: missing_return
            //return '';
          }
        },
        onSaved: onClick,
        obscureText: hint == 'Enter Your Password' ? true : false,
        cursorColor: kMainColor,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon,color:kMainColor),
          filled: true,
          fillColor: kSecondaryColor,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color:Colors.white,
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color:Colors.white,
              )
          ),
          border:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color:Colors.white,
              )
          ),
        ),
      ),
    );
  }
}