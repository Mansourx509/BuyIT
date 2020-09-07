//import 'package:flutter/cupertino.dart';

class Product
{
  String pName;
  String pDescription;
  String pPrice;
  String pCategory;
  String pLocation;
  String pId;
  int pQuantity;
  Product({
    this.pQuantity,
    this.pId,
    this.pName ,
    this.pPrice ,
    this.pDescription,
    this.pCategory ,
    this.pLocation, //{kProductCategory, kProductName, kProductPice, kProductDescription, kProductLocation}
  });
}

//(price->Description ,,location->price ,,name,,categoray,,descrition->location )

