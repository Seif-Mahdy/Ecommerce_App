import 'package:ecommerceapp/models/product.dart';
import 'package:ecommerceapp/services/firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class EditProduct extends StatefulWidget {
  static String id = 'EditProduct';

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KBackGroundColor,
      body: FutureBuilder<List<Product>>(
        future: _store.loadProducts(),
        builder: (context, snapshot) {
          if(snapshot.hasData)
            {
              return GridView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(child: Image.asset(snapshot.data[index].pImageLocation,fit: BoxFit.fill,)),
                    ],
                  ),
                ),
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              );
            }
            else return Center(child: Text('Loading....'));
        }
      ),
    );
  }
}
