import 'package:buyit/constants.dart';
import 'package:buyit/provider/modelHud.dart';
import 'package:buyit/screens/admin/adminHome.dart';
import 'package:buyit/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:buyit/widgets/custom_textfield.dart';
import 'package:buyit/services/auth.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:buyit/main.dart';
import 'package:provider/provider.dart';
import 'package:buyit/screens/user/HomePage.dart';
import 'package:buyit/provider/adminMode.dart';
import 'package:buyit/widgets/custom_logo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _GlobalKey = GlobalKey<FormState>();

  String _email, _password;

  final _auth = Auth();

  bool isAdmin = false;

  final adminPassword = 'admin1234';

  bool keepMeLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: Form(
        key: _GlobalKey,
        child: ModalProgressHUD(
          inAsyncCall: Provider.of<ModelHud>(context).isLoading,
          child: ListView(
            children: <Widget>[
              CustomLogo(),
              SizedBox(
                height: height * 0.1,
              ),
              CustomTextField(
                onClick: (value) {
                  _email = value;
                },
                hint: 'Enter Your Email',
                icon: Icons.email,
              ),
              SizedBox(
                height: height *.02,
              ),
              CustomTextField(
                onClick: (value) {
                  _password = value;
                },
                hint: 'Enter Your Password',
                icon: Icons.lock,
              ),
              Padding(
                padding: const EdgeInsets.only(left:30),
                child: Row(
                  children: <Widget>[
                    Theme(
                      data:ThemeData(
                        unselectedWidgetColor: Colors.white
                      ),
                      child: Checkbox(
                        checkColor: kSecondaryColor,
                        activeColor: kMainColor,
                        value: keepMeLoggedIn,
                        onChanged: (value){
                          setState(() {
                            keepMeLoggedIn = value;
                          });
                        }
                   ),
                    ),
                   Text('Remember Me',style: TextStyle(color:Colors.white),),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder: (context) => FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      if(keepMeLoggedIn == true){
                        keepUserLoggedIn();
                      }
                      _validate(context);
                    },
                    color: Colors.black,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't Have an account !",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignupScreen.id);
                    },
                    child: Text(
                      'SignUp',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Provider.of<AdminMode>(context, listen: false)
                            .changeIsAdmin(true);
                      },
                      child: Text(
                        "I'm an admin",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Provider.of<AdminMode>(context).isAdmin
                                ? kMainColor
                                : Colors.white),
                      ),
                    )),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Provider.of<AdminMode>(context, listen: false)
                            .changeIsAdmin(false);
                      },
                      child: Text(
                        "Iam a user",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Provider.of<AdminMode>(context).isAdmin
                                ? Colors.white
                                : kMainColor),
                      ),
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async{
    final modelHud = Provider.of<ModelHud>(context,listen: false);
    modelHud.changeIsLoading(true);
    if (_GlobalKey.currentState.validate()) {
      _GlobalKey.currentState.save();
      if (Provider.of<AdminMode>(context,listen: false).isAdmin) {
        if (_password == adminPassword) {
          try {
            await _auth.SignIn(_email, _password);
            Navigator.pushNamed(context, AdminHome.id);
          } catch (e) {
            modelHud.changeIsLoading(false);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(e.message),
            ));
          }
        } else {
          modelHud.changeIsLoading(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              'something went Wrong',
            ),
          ));
        }
      } else {
        try {
          await _auth.SignIn(_email, _password);
          Navigator.pushNamed(context, HomePage.id);
        } catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(e.message),
          ));
        }
      }
    }
    modelHud.changeIsLoading(false);
  }

  void keepUserLoggedIn() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(kKeepMeLoggedIN, keepMeLoggedIn);
  }
}

