import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/models/product.dart';

class Store
{
  final Firestore _fireStore = Firestore.instance;
  addProduct(Product product){
    _fireStore.collection(KProductCollectionName).add(
      {
        KProductName : product.pName,
        KProductPrice : product.pPrice,
        KProductCategory : product.pCategory,
        KProductDescription : product.pDescription,
        KProductImageLocation : product.pImageLocation,
      }
    );
  }
  Future<List<Product>> loadProducts()async
  {
   var snapshot = await _fireStore.collection(KProductCollectionName).getDocuments();
   List<Product> products = [];
   for (var doc in snapshot.documents)
     {
       var data = doc.data;
       products.add(Product(
         pName: data[KProductName],
         pPrice: data[KProductPrice],
         pCategory: data[KProductCategory],
         pDescription: data[KProductDescription],
         pImageLocation: data[KProductImageLocation],
       ));
     }
   return products;
  }
}