import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/models/product.dart';
import 'package:ecommerceapp/services/firestore.dart';
import 'package:ecommerceapp/widgets/customButton.dart';
import 'package:ecommerceapp/widgets/customTextField.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddProduct extends StatelessWidget {
  static String id = 'AddProduct';
  final globalKey = GlobalKey<FormState>();
  String _pName, _pPrice, _pDescription, _pImageLocation, _pCategory;
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KBackGroundColor,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
            child: Form(
              key: globalKey,
              child: Column(
                children: <Widget>[
                  CustomTextField(
                    hint: 'Product Name',
                    onClick: (value) {
                      _pName = value;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    hint: 'Product Price',
                    onClick: (value) {
                      _pPrice = value;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    hint: 'Product Description',
                    onClick: (value) {
                      _pDescription = value;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    hint: 'Product Category',
                    onClick: (value) {
                      _pCategory = value;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    hint: 'Product Image Location',
                    onClick: (value) {
                      _pImageLocation = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Builder(
                    builder:(context)=> CustomButton(
                      width: 120,
                      height: 57,
                      onPressed: () {
                        if (globalKey.currentState.validate()) {
                          globalKey.currentState.save();
                          globalKey.currentState.reset();
                          try {
                            _store.addProduct(Product(
                                pName: _pName,
                                pPrice: _pPrice,
                                pCategory: _pCategory,
                                pDescription: _pDescription,
                                pImageLocation: _pImageLocation));
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Color.fromRGBO(255, 255, 255, 0.2),
                              content: Text(
                                'Product added successfully',
                                style: TextStyle(
                                    color: Color.fromRGBO(227, 73, 124, 1),
                                    fontWeight: FontWeight.bold),
                              ),
                            ));
                          }
                          catch(e)
                        {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            backgroundColor: Color.fromRGBO(255, 255, 255, 0.2),
                            content: Text(
                              e.message,
                              style: TextStyle(
                                  color: Color.fromRGBO(227, 73, 124, 1),
                                  fontWeight: FontWeight.bold),
                            ),
                          ));
                        }
                        }
                      },
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color.fromARGB(1000, 72, 93, 242),
                          Color.fromARGB(1000, 227, 73, 124)
                        ],
                      ),
                      child: Text(
                        'Add Product',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
