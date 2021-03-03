import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_app/src/models/products.dart';


class ProductServices {
  String collection = "products";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> getProducts() async =>
      _firestore.collection(collection).get().then((result) {
        List<ProductModel> products = [];
        for(DocumentSnapshot product in result.docs){
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  void likeOrDislikeProduct({String id, List<String> userLikes}){
    _firestore.collection(collection).doc(id).update({
      "userLikes": userLikes
    });
  }

  Future<List<ProductModel>> getProductsbyCategory({String category}) async =>
      _firestore
        .collection(collection)
        .where("category", isEqualTo: category)
        .get()
        .then((result){
          List<ProductModel> products= [];
          for(DocumentSnapshot product in result.docs){
            products.add(ProductModel.fromSnapshot(product));
          }
          return products;
      });

  Future<List<ProductModel>> getFeaturedProducts() async =>
  _firestore
      .collection(collection)
      .where("featured", isEqualTo: true)
      .get()
      .then((result){
        List<ProductModel> products = [];
        for(DocumentSnapshot product in result.docs){
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
  });

  Future<List<ProductModel>> searchProducts({String productName}) {
    String searchKey = productName[0].toUpperCase() + productName.substring(1);
    return _firestore.collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .get()
        .then((result){
          List<ProductModel> products = [];
          for(DocumentSnapshot product in result.docs) {
            products.add(ProductModel.fromSnapshot(product));
          }
          return products;
    });
  }

}