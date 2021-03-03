import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/src/helpers/order.dart';
import 'package:restaurant_app/src/helpers/userServices.dart';
import 'package:restaurant_app/src/models/order.dart';
import 'package:restaurant_app/src/models/products.dart';
import 'package:restaurant_app/src/models/user.dart';
import 'package:restaurant_app/src/models/cart_item.dart';
import 'package:uuid/uuid.dart';

enum Status { Uninitialized, Unauthenticated, Authenticating, Authenticated }

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserServices _userServices = UserServices();
  OrderServices _orderServices = OrderServices();
  UserModel _userModel;

  Status get status => _status;
  User get user => _user;
  UserModel get userModel => _userModel;

  List<OrderModel> orders = [];

  final formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();

  AuthProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }

  Future<bool> signIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((user) {
        Map<String, dynamic> values = {
          "name": name.text,
          "email": email.text,
          "uid": user.user.uid,
          "phone": phone.text,
          "likedFood": [],
        };
        _userServices.createUser(values);
      });
      //_userServices.createUser();
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
      _userModel = await _userServices.getUserById(user.uid);
    }
    notifyListeners();
  }

  Future<void> reloadUserModel() async {
    _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }

  void clearController() {
    name.text = " ";
    password.text = " ";
    email.text = " ";
    phone.text = " ";
  }

  Future<bool> addToCard({ProductModel product, int quantity}) async {
    print("THE PRODUCT IS: ${product.toString()}");
    print("THE qty is: ${quantity.toString()}");

    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      bool itemExists = false;
      List cart = _userModel.cart;
      Map cartItem = {
        "id": cartItemId,
        "name": product.name,
        "image": product.image,
        "productId": product.id,
        "price": product.price,
        "quantity": quantity,
      };

        CartItemModel item = CartItemModel.fromMap(cartItem);
        if (!itemExists) {
        print("CART ITEMS ARE: ${cart.toString()}");
        _userServices.addToCart(userId: _user.uid, cartItem: item);
        }

      return true;
    } catch (e) {
      print("THe ERROR ${e.toString()}");
      return false;
    }
  }

  Future<bool> removeFromCart({CartItemModel cartItem}) async {
    print("The PRODUCT IS: ${cartItem.toString()}");

    try {
      _userServices.removeFromCart(userId: _user.uid, cartItem: cartItem);
      return true;
    } catch (e) {
      print("THe ERROR ${e.toString()}");
      return false;
    }
  }

  bool _onError(String error) {
    _status = Status.Unauthenticated;
    notifyListeners();
    print("We got an error: $error");
    return false;
  }

  getOrders() async {
    orders = await _orderServices.getUserOrders(userId: _user.uid);
    notifyListeners();
  }
}
