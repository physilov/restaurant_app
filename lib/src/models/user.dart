
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

  UserModel.fromSnapshot(DocumentSnapshot snapshot){
    _name = snapshot.data()[NAME];
    _email = snapshot.data()[EMAIL];
    _id = snapshot.data()[ID];
    _phone = snapshot.data()[PHONE];
    _stripeId = snapshot.data()[STRIPE_ID];
    cart = _convertCartItems(snapshot.data()[CART]) ?? [];
    totalCartPrice = snapshot.data()[CART] == null ? 0 :getTotalPrice(cart: snapshot.data()[CART]);
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
    for(Map cartItem in cart){
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }

}

