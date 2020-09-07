import 'package:buyit/models/product.dart';
import 'package:buyit/screens/user/productInfo.dart';
import 'package:buyit/services/store.dart';
import 'package:buyit/widgets/custom_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:buyit/provider/cartItem.dart';
import '../../constants.dart';

class CartScreen extends StatelessWidget {
  static String id = 'CartScreen';

  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).products;
    final double ScreenHeight = MediaQuery.of(context).size.height;
    final double ScreenWidth = MediaQuery.of(context).size.width;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBArHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('My Cart', style: TextStyle(color: Colors.black)),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Column(
        children: <Widget>[
          LayoutBuilder(builder: (context, constraints) {
            if (products.isNotEmpty) {
              return Container(
                height: ScreenHeight -
                    appBarHeight -
                    statusBArHeight -
                    (ScreenHeight * .08),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: GestureDetector(
                        onTapUp: (details) {
                          

                          showCustomMenu(details , context,products[index]);
                        
                        
                        
                        },
                        child: Container(
                          height: ScreenHeight * .15,
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: ScreenHeight * .15 / 2,
                                backgroundImage:
                                    AssetImage(products[index].pLocation),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            products[index].pName,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            '\$ ${products[index].pPrice}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text(
                                        products[index].pQuantity.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          color: kSecondaryColor,
                        ),
                      ),
                    );
                  },
                  itemCount: products.length,
                ),
              );
            } else {
              return Container(
                  height: ScreenHeight -
                      (ScreenHeight * .08) -
                      appBarHeight -
                      statusBArHeight,
                  child: Center(
                    child: Text('Cart is Empty'),
                  ));
            }
          }),
          Builder(
            builder:(context)=> ButtonTheme(
              minWidth: ScreenWidth,
              height: ScreenHeight * .08,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                onPressed: () {

                  showCustomDialog(products, context);

                },
                child: Text('Order'.toUpperCase()),
                color: kMainColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  void showCustomMenu(details , context , product) {
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double dx2 = MediaQuery.of(context).size.width - dx;
    double dy2 = MediaQuery.of(context).size.width - dy;
    showMenu(
        context: context,
        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
        items: [
          MyPopUpMenuItem(
            onClick: () {
              Navigator.pop(context);
              Provider.of<CartItem>(context, listen: false).deleteProduct(product);
              Navigator.pushNamed(context,ProductInfo.id, arguments:product);
            },
            child: Text('Edit'),
          ),
          MyPopUpMenuItem(
            onClick: () {
              Navigator.pop(context);
              Provider.of<CartItem>(context, listen: false).deleteProduct(product);
            },
            child: Text('Delete'),
          )
        ]);
  }

  void showCustomDialog(List <Product> products , context)async {
    var price = getTotalPrice(products);
    var address;
    AlertDialog alertDialog = AlertDialog(
      actions: <Widget>[
        MaterialButton(
          onPressed: (){
            try{
              Store _store = Store();
              _store.storeOrders({
                kTotalPrice : price,
                kAddress : address
              },products);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Ordered successfully'),
              ));
              Navigator.pop(context);
            }catch(e){
              print(e.message);
            }
          },
          child: Text('Confirm'),
        )
      ],
      content: TextField(
        onChanged: (value){
          address = value;
        },
        decoration:InputDecoration(
          hintText:'Enetr your Adress',
        )
      ),
      title: Text('Total Price = \$ $price ')
    );
    await showDialog(context: context, builder:(context){
      return alertDialog;
    } );
  }

   getTotalPrice(List<Product> products) 
  {
    var price = 0;
    for(var product in products){
      price += product.pQuantity * int.parse(product.pPrice);
    }
    return price;
  }
}
