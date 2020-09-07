import 'package:buyit/provider/modelHud.dart';
import 'package:buyit/screens/login_screeen.dart';
import 'package:buyit/widgets/custom_logo.dart';
import 'package:buyit/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';
import 'package:buyit/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'user/HomePage.dart';
import 'package:buyit/main.dart';

class SignupScreen extends StatelessWidget{

  static String id = 'SignupScreen';
  String _email , _password ;
  final _auth = Auth();
  final GlobalKey<FormState> _glabalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: kMainColor,
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<ModelHud>(context).isLoading,
          child: Form(
            key: _glabalKey,
            child: ListView(
              children: <Widget>[
                CustomLogo(),
                SizedBox(
                  height: height*0.05,
                ),
                CustomTextField(
                  onClick: (value){},
                  icon: Icons.person,
                  hint: 'Enter Your Name',
                ),
                SizedBox(
                  height: height*0.02,
                ),
                CustomTextField(
                  onClick: (value){
                    _email = value ;
                  },
                  hint: 'Enter Your Email',
                  icon: Icons.email,
                ),
                SizedBox(
                  height: height*0.02,
                ),
                CustomTextField(
                  onClick: (value){
                    _password = value;
                  },
                  hint: 'Enter Your Password',
                  icon: Icons.lock,
                ),
                SizedBox(
                  height: height*0.05,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 120),
                  child: Builder(
                    builder:(context)=> FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: ()async
                      {
                        final modelhud = Provider.of<ModelHud>(context,listen:false);
                        modelhud.changeIsLoading(true);
                        if(_glabalKey.currentState.validate()){
                          _glabalKey.currentState.save();
                          try {
                            final authResult = await _auth.SignUp(_email.trim(), _password.trim());
                            modelhud.changeIsLoading(false);
                            Navigator.pushNamed(context, HomePage.id);
                          }on PlatformException catch(e){
                            modelhud.changeIsLoading(false);
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  e.message
                              ),
                            ));
                          }
                        }
                        // 
                        modelhud.changeIsLoading(false);
                      },
                      color: Colors.black,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height*0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Have an account !",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    //);
  }
}

