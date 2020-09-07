import 'package:buyit/models/product.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import '../constants.dart';

class Store{
  final Firestore _firestore = Firestore.instance;

  AddProduct(Product product){

    _firestore.collection(kProductCollection).add(
      {
        kProductName : product.pName,
        kProductPice : product.pPrice,
        kProductDescription : product.pDescription,
        kProductCategory : product.pCategory,
        kProductLocation : product.pLocation,
 
      });
  }

  Stream<QuerySnapshot> loadProducts() {
     return _firestore.collection(kProductCollection).snapshots();
  }

  Stream<QuerySnapshot> loadOrders(){
    return _firestore.collection(kOrders).snapshots();
  }

  Stream<QuerySnapshot> loadOrderDetails(documentId){
    return _firestore.collection(kOrders).document(documentId).collection(kOrederDetails).snapshots();
  }


  deleteProduct(documentId){
    _firestore.collection(kProductCollection).document(documentId).delete();
  }

  editProduct(data,documentId){
    _firestore.collection(kProductCollection).document(documentId).updateData(data);
  }

  storeOrders(data , List<Product> products)
  {
    var documentRef =_firestore.collection(kOrders).document();
    documentRef.setData(data);
    for(var product in products){
      documentRef.collection(kOrederDetails).document().setData({
        kProductName : product.pName,
        kProductPice : product.pPrice,
        kProductQuantity : product.pQuantity,
        kProductLocation : product.pLocation,
        kProductCategory : product.pCategory
      });
    }
  }

}