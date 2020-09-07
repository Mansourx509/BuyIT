import 'package:buyit/constants.dart';
import 'package:buyit/models/order.dart';
import 'package:buyit/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'orderDetails.dart';

class OrdersScreen extends StatelessWidget {

  static String id = 'OrdersScreen'; 
  final Store _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>
      (
        stream:_store.loadOrders() ,
        builder: (context,snapshot){
          if(!snapshot.hasData)
          {
            return Center(child:Text('There are no orders'));
          }else{
            List<Order> orders = [];
            for(var doc in snapshot.data.documents){
              orders.add(Order(
                documentId: doc.documentID,
                totalPrice: doc.data[kTotalPrice],
                address: doc.data[kAddress]
              ));
            }
            return ListView.builder(
              itemBuilder:(context,index)=>
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, OrderDetails.id, arguments: orders[index].documentId);
                    },
                    child: Container(
                      height:MediaQuery.of(context).size.height*.2,
                      color:kSecondaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Total Price : \$ ${orders[index].totalPrice}',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold),),
                            SizedBox(height:10),
                            Text('Address is ${orders[index].address}', style: TextStyle(fontSize:18,fontWeight:FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              itemCount: orders.length,  
              
            );
          }
        },
      ),
    );
  }
}