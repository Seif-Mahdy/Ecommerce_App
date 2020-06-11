import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/models/product.dart';
import 'package:ecommerceapp/services/firestore.dart';
import 'package:ecommerceapp/widgets/customPopUpMenuItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'editProducts.dart';

class ManageProducts extends StatefulWidget {
  static String id = 'ManageProducts';

  @override
  _ManageProductsState createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KBackGroundColor,
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> products = [];
              for (var doc in snapshot.data.documents) {
                var data = doc.data;
                products.add(Product(
                  pId: doc.documentID,
                  pName: data[KProductName],
                  pPrice: data[KProductPrice],
                  pCategory: data[KProductCategory],
                  pDescription: data[KProductDescription],
                  pImageLocation: data[KProductImageLocation],
                ));
              }
              return GridView.builder(
                itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: GestureDetector(
                    onTapUp: (details) async {
                      var left = details.globalPosition.dx;
                      var top = details.globalPosition.dy;
                      var right = MediaQuery.of(context).size.width - left;
                      var bottom = MediaQuery.of(context).size.height - top;
                      await showMenu(
                          context: context,
                          position:
                              RelativeRect.fromLTRB(left, top, right, bottom),
                          items: [
                            CustomPopUpMenuItem(
                              onclick: () {
                                Navigator.pushNamed(context, EditProduct.id , arguments: products[index].pId);
                              },
                              child: Text('Edit'),
                            ),
                            CustomPopUpMenuItem(
                              onclick: () {
                                _store.deleteProduct(products[index].pId);
                                Navigator.pop(context);
                              },
                              child: Text('Delete'),
                            ),
                          ]);
                    },
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                            child: Image.asset(
                          products[index].pImageLocation,
                          fit: BoxFit.fill,
                        )),
                        Positioned(
                          bottom: 0,
                          child: Opacity(
                            opacity: 0.6,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      products[index].pName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('\$ ${products[index].pPrice}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
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
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.8),
              );
            } else
              return Center(child: Text('Loading....'));
          }),
    );
  }
}
