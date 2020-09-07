import 'package:buyit/constants.dart';
import 'package:buyit/provider/adminMode.dart';
import 'package:buyit/provider/cartItem.dart';
import 'package:buyit/provider/modelHud.dart';
import 'package:buyit/screens/admin/addProduct.dart';
import 'package:buyit/screens/admin/adminHome.dart';
import 'package:buyit/screens/admin/editProduct.dart';
import 'package:buyit/screens/admin/manageProducts.dart';
import 'package:buyit/screens/admin/ordersScreen.dart';
import 'package:buyit/screens/login_screeen.dart';
import 'package:buyit/screens/signup_screen.dart';
import 'package:buyit/screens/user/cartScreen.dart';
import 'package:buyit/screens/user/productInfo.dart';
import 'package:flutter/material.dart';
import 'package:buyit/screens/user/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:buyit/screens/admin/orderDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
 main() => runApp(MyApp());

 class MyApp extends StatelessWidget{

   bool isUserLoggerIn = false;

   @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return MaterialApp(home: Scaffold(body: Center(child: Text('Loading...'),),),);
        }else{
          isUserLoggerIn = snapshot.data.getBool(kKeepMeLoggedIN) ?? false;
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<ModelHud>(
                create: (context)=>ModelHud(),),
              ChangeNotifierProvider<CartItem>(
                create: (context)=>CartItem(),),
              ChangeNotifierProvider<AdminMode>(
                create: (context)=>AdminMode(),)
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: isUserLoggerIn ? HomePage.id : LoginScreen.id,
              routes: {
                LoginScreen.id : (context) => LoginScreen(),
                SignupScreen.id : (context) => SignupScreen(),
                HomePage.id :(context) => HomePage(),
                AdminHome.id:(context) => AdminHome(),
                AddProduct.id:(context)=>AddProduct(),
                ManageProducts.id:(context)=>ManageProducts(),
                EditProducts.id :(context)=>EditProducts(),
                ProductInfo.id: (context)=> ProductInfo(),
                CartScreen.id:(context)=>CartScreen(),
                OrdersScreen.id:(context) =>OrdersScreen(),
                OrderDetails.id:(context) =>OrderDetails(),
              },
            ),
          );
        }
      },
    );
  }
 }