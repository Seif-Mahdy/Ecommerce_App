import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/pages/addProduct.dart';
import 'package:ecommerceapp/pages/editProduct.dart';
import 'package:ecommerceapp/pages/viewOrders.dart';
import 'package:ecommerceapp/widgets/customButton.dart';
import 'package:flutter/material.dart';

class AdminControlCenter extends StatelessWidget {
  static String id = 'AdminControlCenter';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KBackGroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomButton(
              width: 120,
              height: 57,
              onPressed: () {
                Navigator.pushNamed(context, AddProduct.id);
              },
              gradient: LinearGradient(
                colors: <Color>[
                  Color.fromARGB(1000, 72, 93, 242),
                  Color.fromARGB(1000, 227, 73, 124)
                ],
              ),
              child: Text(
                'Add Product',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            CustomButton(
              width: 120,
              height: 57,
              onPressed: () {
                Navigator.pushNamed(context, EditProduct.id);
              },
              gradient: LinearGradient(
                colors: <Color>[
                  Color.fromARGB(1000, 72, 93, 242),
                  Color.fromARGB(1000, 227, 73, 124)
                ],
              ),
              child: Text(
                'Edit Product',
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            CustomButton(
              width: 120,
              height: 57,
              onPressed: () {
                Navigator.pushNamed(context, ViewOrders.id);
              },
              gradient: LinearGradient(
                colors: <Color>[
                  Color.fromARGB(1000, 72, 93, 242),
                  Color.fromARGB(1000, 227, 73, 124)
                ],
              ),
              child: Text(
                'View Orders',
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
