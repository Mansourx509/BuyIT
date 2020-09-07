import 'package:buyit/constants.dart';
import 'package:buyit/models/product.dart';
import 'package:buyit/provider/cartItem.dart';
import 'package:buyit/screens/user/cartScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ProductInfo extends StatefulWidget {

  static String id = 'ProductInfo';

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
 
  /*_displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(content: Text('Added to Cart'));
    _scaffoldKey.currentState.showSnackBar(snackBar);  
  }*/

  int _quantity = 1;
  //final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      //key:_scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image(
              fit: BoxFit.fill,
              image: AssetImage(product.pLocation),  
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              //color: Colors.black,
              height: MediaQuery.of(context).size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(
                        Icons.arrow_back_ios ,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){Navigator.pushNamed(context, CartScreen.id);},
                    child: Icon(Icons.shopping_cart),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Column(
              children: <Widget>[
                Opacity(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height *.3,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            product.pName,
                            style:TextStyle(fontSize: 20 , fontWeight:FontWeight.bold,color:Colors.black),
                          ),
                          SizedBox(
                            height:10
                          ),
                          Text(
                            product.pDescription,
                            style:TextStyle(fontSize: 16 , fontWeight:FontWeight.w800,color:Colors.black),
                          ),
                          SizedBox(
                            height:10
                          ),
                          Text(
                            '\$ ${product.pPrice}',
                            style:TextStyle(fontSize: 20 , fontWeight:FontWeight.bold,color:Colors.black),
                          ),
                          SizedBox(
                            height:5
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ClipOval(
                                child: Material(
                                  color: kMainColor,
                                  child: GestureDetector(
                                    onTap: subtract,
                                    child:SizedBox(
                                      child:Icon(Icons.remove)),
                                    ),
                                ),
                              ),
                              Text(
                                _quantity.toString(),
                                style: TextStyle(
                                  fontSize:50,
                                  color: Colors.black
                                ),
                              ),
                              ClipOval(
                                child: Material(
                                  color: kMainColor,
                                  child: GestureDetector(
                                    onTap: add,
                                    child:SizedBox(
                                      child:Icon(Icons.add)),
                                    ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  opacity: .5,
                ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height *.08,
                  child: Builder(
                    builder:(context)=> RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topRight:Radius.circular(10),topLeft:Radius.circular(10)),
                  ),
                  onPressed: (){
                    addToCart(context , product);
                    //_displaySnackBar(context);
                  },
                  color: kMainColor,
                  child: Text(
                    'Add to Cart'.toUpperCase(),
                    style: TextStyle(
                      fontSize:16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
              ],
            )
          )
        ],
      ),
    );
  }

  subtract() {
    if(_quantity > 1){
      setState(() {
        _quantity--;
      });
    }
  }

  add(){
    setState(() {
      _quantity++;
    });
  }
  void addToCart(context , product)
  {
    CartItem cartItem = Provider.of<CartItem>(context , listen: false);
    product.pQuantity = _quantity;
    var productsInCart = cartItem.products;
    bool exist = false;
    for(var productInCart in productsInCart)
    {
      if(productInCart.pName == product.pName)
      {
        exist = true;
      }
    }
    if(exist){
      Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('You\'ve added this item before')));
    }else{
      cartItem.addCart(product);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Added to CArt'),
      ));
    }
    
  }
}

