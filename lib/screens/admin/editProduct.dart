import 'package:buyit/constants.dart';
import 'package:buyit/models/product.dart';
import 'package:buyit/services/store.dart';
import 'package:buyit/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';


class EditProducts extends StatelessWidget {
  static String id = 'EditProducts';

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _id,_name, _price, _description, _category, _imageLocation;
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height*.1,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextField(
                  hint: 'Product Name',
                  onClick: (value) {
                    _name = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hint: 'Product Price',
                  onClick: (value) {
                    _price = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hint: 'Product Description',
                  onClick: (value) {
                    _description = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hint: 'Product Category',
                  onClick: (value) {
                    _category = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hint: 'Product Location',
                  onClick: (value) {
                    _imageLocation = value;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                RaisedButton(
                  onPressed: (){
                    if(_globalKey.currentState.validate()){
                      _globalKey.currentState.save();
                      _store.editProduct(
                          ({
                            kProductName: _name,
                            kProductLocation:_imageLocation,
                            kProductCategory:_category,
                            kProductDescription:_description,
                            kProductPice:_price
                          }),
                          product.pId);
                    }
                  },
                  child: Text('Add Product'),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}
