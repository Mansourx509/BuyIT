//import 'dart:html';

import 'package:buyit/constants.dart';
import 'package:buyit/models/product.dart';
import 'package:buyit/provider/cartItem.dart';
import 'package:buyit/screens/admin/manageProducts.dart';
import 'package:buyit/screens/login_screeen.dart';
import 'package:buyit/screens/user/cartScreen.dart';
import 'package:buyit/screens/user/productInfo.dart';
import 'package:buyit/services/auth.dart';
import 'package:buyit/services/store.dart';
import 'package:buyit/widgets/productView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:buyit/functions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../functions.dart';


class HomePage extends StatefulWidget {
  static String id = 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _store = Store();
  final _auth = Auth();
  FirebaseUser _loggedUser;
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  int _quantity = 1;
  List<Product> _products = [];
  ProductInfo productinfo = ProductInfo();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: _bottomBarIndex,
                unselectedItemColor: kUnActiveColor,
                onTap: (value) async{
                  if(value == 2){ //sign Out
                    SharedPreferences pref = await SharedPreferences.getInstance();
                    pref.clear();
                    await _auth.signOut();
                    Navigator.popAndPushNamed(context , LoginScreen.id);
                  }
                  setState(() {
                    _bottomBarIndex = value;
                  });
                },
                fixedColor: kMainColor,
                items: [
                  BottomNavigationBarItem(
                      title: Text('test'), icon: Icon(Icons.person)),
                  BottomNavigationBarItem(
                      title: Text('Favorite'), icon: Icon(Icons.favorite)),
                  BottomNavigationBarItem(
                      title: Text('Sign Out'), icon: Icon(Icons.close)),
                ],
              ),
              appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  bottom: TabBar(
                    indicatorColor: kMainColor,
                    onTap: (value) {
                      setState(() {
                        _tabBarIndex = value;
                      });
                    },
                    tabs: <Widget>[
                      Text(
                        'jackets',
                        style: TextStyle(
                          color:
                              _tabBarIndex == 0 ? Colors.black : kUnActiveColor,
                          fontSize: _tabBarIndex == 0 ? 16 : null,
                        ),
                      ),
                      Text(
                        'Trousers',
                        style: TextStyle(
                          color:
                              _tabBarIndex == 1 ? Colors.black : kUnActiveColor,
                          fontSize: _tabBarIndex == 1 ? 16 : null,
                        ),
                      ),
                      Text(
                        'T-Shirts',
                        style: TextStyle(
                          color:
                              _tabBarIndex == 2 ? Colors.black : kUnActiveColor,
                          fontSize: _tabBarIndex == 2 ? 16 : null,
                        ),
                      ),
                      Text(
                        'Shoes',
                        style: TextStyle(
                          color:
                              _tabBarIndex == 3 ? Colors.black : kUnActiveColor,
                          fontSize: _tabBarIndex == 3 ? 16 : null,
                        ),
                      ),
                    ],
                  )),
              body: TabBarView(
                children: <Widget>[
                  jacketView(),
                  ProductView(kTrousers,_products),
                  ProductView(kTshirts,_products),
                  ProductView(kShoes,_products)
                ],
              )),
        ),
        Material(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              //color: Colors.black,
              height: MediaQuery.of(context).size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Discover'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){Navigator.pushNamed(context, CartScreen.id);},
                    child: Icon(Icons.shopping_cart)
                    ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentUser();
  }

  getCurrentUser() async {
    _loggedUser = await _auth.getUser();
  }

  jacketView() {
    return StreamBuilder<QuerySnapshot>(
        stream: _store.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              var product = Product(
                pId: doc.documentID,
                pPrice: data[kProductPice],
                pName: data[kProductName],
                pDescription: data[kProductDescription],
                pLocation: data[kProductLocation],
                pCategory: data[kProductCategory]);
              products.add(product);
            }
            bool _favorite = false;
            _products = [...products];
            products.clear();
            products = getProductByCategory(kJackets,_products);

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, ProductInfo.id,arguments: products[index]);
                  },
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image(
                            fit: BoxFit.fill,
                            image: AssetImage(products[index].pLocation)),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: 0.6,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    products[index].pName,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),                                  
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              itemCount: products.length,
            );
          } else {
            return Center(child: Text("loading...."));
          }
        });
  }

  
}
