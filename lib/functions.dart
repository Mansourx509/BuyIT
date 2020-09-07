import 'package:flutter/cupertino.dart';

import 'models/product.dart';

List<Product> getProductByCategory(String kJackets, List<Product> allProducts) {
    List<Product> products = [];
    try{
      for (var product in allProducts) {
      if (product.pCategory == kJackets) {
        products.add(product);
      }
    }}on Error catch(e){
      print(e);
    }
    
    return products;
  }