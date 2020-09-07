import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('images/icons/logo.png'),
            ),
            Positioned(
              bottom: 0,
              child: Text('Buy it',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 25,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}