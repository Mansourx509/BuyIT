import 'package:buyit/constants.dart';
import 'package:buyit/screens/admin/addProduct.dart';
import 'package:buyit/screens/admin/manageProducts.dart';
import 'package:buyit/screens/admin/ordersScreen.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget{
  static String id = 'AdminPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          RaisedButton(
            onPressed: ()
            {
              Navigator.pushNamed(context, AddProduct.id);
            },
            child: Text('add product'),
          ),
          RaisedButton(
            onPressed: (){
              Navigator.pushNamed(context, ManageProducts.id);
            },
            child: Text('edit product'),
          ),
          RaisedButton(
            onPressed: (){
              Navigator.pushNamed(context, OrdersScreen.id);
            },
            child: Text('view orders'),
          ),
        ],
      ),
    );
  }
}