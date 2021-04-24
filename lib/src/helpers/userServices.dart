import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_app/src/models/cart_item.dart';
import 'package:restaurant_app/src/models/user.dart';

class UserServices{
  String collection = "users";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void createUser({String id, String name, String email,})  {

    _firestore.collection(collection).doc(id).set({
      "name": name,
      "id": id,
      "email": email,
    });
  }


/*  void updateUserData(Map<String, dynamic> values){
    _firestore.collection(collection).doc(values['id']).update(values);
  }*/

  void addToCart({String userId, CartItemModel cartItem}){
    print("The user id is: $userId");
    print("The cart items are: ${cartItem.toString()}");
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayUnion([cartItem.toMap()])
    });
  }

  void removeFromCart({String userId, CartItemModel cartItem}){
    print("The user ud is: $userId");
    print("The cart items are: ${cartItem.toString()}");
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayRemove([cartItem.toMap()])
    });
  }

  Future<UserModel> getUserById(String id) => _firestore.collection(collection).doc(id).get().then((doc){
    return UserModel.fromDocumentSnapshot(doc);
});


  Future<bool> doesUserExist(String id) async => _firestore
      .collection(collection)
      .doc(id)
      .get()
      .then((value) => value.exists);
}