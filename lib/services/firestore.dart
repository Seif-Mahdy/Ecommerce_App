import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/constants.dart';
import 'package:ecommerceapp/models/product.dart';

class Store {
  final Firestore _fireStore = Firestore.instance;

  addProduct(Product product) {
    _fireStore.collection(KProductCollectionName).add(
        {
          KProductName: product.pName,
          KProductPrice: product.pPrice,
          KProductCategory: product.pCategory,
          KProductDescription: product.pDescription,
          KProductImageLocation: product.pImageLocation,
        }
    );
  }

  Stream<QuerySnapshot> loadProducts() {
    return _fireStore.collection(KProductCollectionName).snapshots();
  }
  deleteProduct(documentId)
  {
    _fireStore.collection(KProductCollectionName).document(documentId).delete();
  }
  editProduct(data , documentId)
  {
    _fireStore.collection(KProductCollectionName).document(documentId).updateData(data);
  }
}