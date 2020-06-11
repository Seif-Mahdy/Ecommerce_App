import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/models/product.dart';
import 'package:ecommerceapp/services/firestore.dart';
import 'package:ecommerceapp/widgets/customPopUpMenuItem.dart';
import 'package:flutter/material.dart';

import 'editProducts.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabBarIndex = 0;
  int _bottomNavigationIndex = 0;
  List<Product> _products = [];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (value)
              {
                setState(() {
                  _bottomNavigationIndex = value;
                });
              },
              fixedColor: KBackGroundColor,
              currentIndex: _bottomNavigationIndex,
              items:[
                BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    title: Text('test'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text('test'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text('test'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text('test'),
                ),
              ],
            ),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              bottom: TabBar(
                indicatorColor: KBackGroundColor,
                onTap: (value)
                {
                  setState(() {
                    _tabBarIndex = value;
                  });

                },
                tabs: <Widget>[
                  Text('Mobiles',style: TextStyle(
                    color: _tabBarIndex == 0 ? Colors.black : Colors.grey,
                    fontSize: _tabBarIndex == 0 ? 16 : null,
                  ),),
                  Text('Tablets',style: TextStyle(
                      color: _tabBarIndex == 1 ? Colors.black : Colors.grey,
                      fontSize: _tabBarIndex == 1 ? 16 : null,
                  ),),
                  Text('Watches',style: TextStyle(
                      color: _tabBarIndex == 2 ? Colors.black : Colors.grey,
                    fontSize: _tabBarIndex == 2 ? 16 : null,
                  ),),
                  Text('Laptops',style: TextStyle(
                      color: _tabBarIndex == 3 ? Colors.black : Colors.grey,
                    fontSize: _tabBarIndex == 3 ? 16 : null,
                  ),),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                mobileView(),
                productView(KTablets),
                productView(KWatches),
                productView(KLaptops),
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20,30,20,0),
            child: Container(
              height: MediaQuery.of(context).size.height*0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Discover'.toUpperCase(),style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                  Icon(Icons.shopping_cart),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget mobileView() {
    final _store = Store();
    return StreamBuilder<QuerySnapshot>(
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
            _products = [...products];
            products.clear();
            products = getProductByCategory(KMobiles);
            return GridView.builder(
              itemBuilder: (context, index) => Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
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
        });
  }

  List<Product> getProductByCategory(category) {
    List<Product>products = [];
    for(var product in _products)
    {
      if(product.pCategory == category)
      {
        products.add(product);
      }
    }
    return products;
  }

 Widget productView(String category) {
    List<Product> products = [];
    products = getProductByCategory(category);
   return GridView.builder(
     itemBuilder: (context, index) => Padding(
       padding:
       const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
       child: GestureDetector(
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
 }
}
