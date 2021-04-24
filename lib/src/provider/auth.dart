

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:restaurant_app/src/helpers/constants.dart';
import 'package:restaurant_app/src/helpers/order.dart';
import 'package:restaurant_app/src/helpers/userServices.dart';
import 'package:restaurant_app/src/models/order.dart';
import 'package:restaurant_app/src/models/products.dart';
import 'package:restaurant_app/src/models/user.dart';
import 'package:restaurant_app/src/models/cart_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

enum Status { Uninitialized, Unauthenticated, Authenticating, Authenticated }

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  //FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserServices _userServices = UserServices();
  OrderServices _orderServices = OrderServices();
  UserModel _userModel;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["https://mail.google.com/"]);
  Status get status => _status;
  User get user => _user;
  UserModel get userModel => _userModel;

  List<OrderModel> orders = [];

  final formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();

  AuthProvider.init() {
    _fireSetUp();
  }

  _fireSetUp() async {
    await initialization.then((value){
      auth.authStateChanges().listen(_onStateChanged);
    });
  }

 /* AuthProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }*/

  Future<void> _onStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Uninitialized;
    } else {
      _user = firebaseUser;
      initializeUserModel();
      Future.delayed(const Duration(seconds: 2), (){
        _status = Status.Authenticated;
      });

     // _userModel = await _userServices.getUserById(user.uid);
      //initializeUserModel();

    }
    notifyListeners();
  }

  Future<bool> initializeUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String _userId = preferences.getString('id');
    _userModel = await _userServices.getUserById(_userId);
    notifyListeners();
    if(_userModel == null) {
      return false;
    } else {
      return true;
    }
  }


  Future<bool> signIn()async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      final result = await _auth.signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
      //User user = result.user;
      await initializeUserModel();
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential).then((
          userCredentials) async  {
        _user = userCredentials.user;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("id", _user.uid);
        if (!await _userServices.doesUserExist(_user.uid)) {
        _userServices.createUser(
          id: _user.uid,
          name: _user.displayName,
          email: _user.email
        );

          await initializeUserModel();
        } else {
          await initializeUserModel();
        }
      });
      return {'success': true, 'message': 'success'};
    } catch (e) {
      return {'success': true, 'message': e.toString()};
    }
  }




  Future<bool> signUp()async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim()).then((result) async {
        _user = result.user;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("id", _user.uid);
        if(!await _userServices.doesUserExist(_user.uid)){
          _userServices.createUser(
            id: _user.uid,
            name: _user.displayName,
            email: _user.email,
          );
          await initializeUserModel();
        } else {
          await initializeUserModel();
        }
        /*_firestore.collection("users").doc(result.user.uid).set({
          'name':name.text,
          'email':email.text,
          'id':result.user.uid,
          "likedFood": [],
          "likedRestaurants": []

        }

        );*/
      });
      assert(user != null);
      assert(await user.getIdToken() != null);

      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut()async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
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
   //   bool itemExists = false;
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
    //    if (!itemExists) {
        print("CART ITEMS ARE: ${cart.toString()}");
        _userServices.addToCart(userId: _user.uid, cartItem: item);
    //    }

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
