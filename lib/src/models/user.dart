
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_app/src/models/cart_item.dart';

class UserModel{
  static const NAME = "name";
  static const EMAIL = "email";
  static const ID = "id";
  static const STRIPE_ID = "stripeId";
  static const PHONE = "phone";
  static const CART = "cart";

  String _name;
  String _email;
  String _id;
  String _phone;
  String _stripeId;
  int _priceSum = 0;
  int _quantitySum = 0;


  String get name => _name;
  String get email => _email;
  String get id => _id;
  String get phone => _phone;
  String get stripeId => _stripeId;

  List<CartItemModel> cart;
  int totalCartPrice;

  UserModel.fromDocumentSnapshot(DocumentSnapshot doc){
    _name = doc.data()[NAME];
    _email = doc.data()[EMAIL];
    _id = doc.data()[ID];
    _phone = doc.data()[PHONE];
    _stripeId = doc.data()[STRIPE_ID];
    cart = _convertCartItems(doc.data()[CART]) ?? [];
    totalCartPrice = doc.data()[CART] == null ? 0 :getTotalPrice(cart: doc.data()[CART]);
  }

  int getTotalPrice({List cart}){
    if(cart == null){
      return 0;
    }
    for(Map cartItem in cart){
      _priceSum += cartItem["price"] * cartItem["quantity"];
    }
    int total = _priceSum;

    print("The total is $total");
    return total;


  }

  List<CartItemModel> _convertCartItems(List cart){
    List<CartItemModel> convertedCart = [];
    if(cart != null){
      for(Map cartItem in cart){
        convertedCart.add(CartItemModel.fromMap(cartItem));
      }

    }

    return convertedCart;
  }

}

