import 'package:buyit/constants.dart';
import 'package:buyit/models/product.dart';
import 'package:buyit/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:buyit/services/store.dart';

class AddProduct extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = 'AddProduct';
  String _id, _name, _price, _description, _category, _imageLocation;
  int _quantity = 1;
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      //resizeToAvoidBottomPadding: false,
      body: Form(
        key: _globalKey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
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
                  color: kSecondaryColor,
                  onPressed: () {
                    if (_globalKey.currentState.validate()) {
                      _globalKey.currentState.save();
                      _store.AddProduct(Product(
                      pName: _name,
                      pPrice: _price,
                      pDescription: _description,
                      pLocation: _imageLocation,
                      pCategory: _category));
                    }
                  },
                  child: Text('Add Product'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
