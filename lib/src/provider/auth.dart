import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/src/helpers/userServices.dart';
import 'package:restaurant_app/src/models/user.dart';

enum Status{Uninitialized, Unauthenticated, Authenticating, Authenticated}

class AuthProvider with ChangeNotifier{
  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserServices _userServices = UserServices();
  UserModel _userModel;

  Status get status => _status;
  User get user => _user;
  UserModel get userModel => _userModel;

  final formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();

  AuthProvider.initialize(): _auth = FirebaseAuth.instance{
    _auth.authStateChanges().listen(_onStateChanged);
  }

  Future<void> _onStateChanged(User firebaseUser) async {
    if(firebaseUser == null){
      _status = Status.Uninitialized;
    }else {
      _user = firebaseUser;
      _status = Status.Authenticated;
      _userModel = await _userServices.getUserById(firebaseUser.uid);
    }
    notifyListeners();
  }

  Future<bool> signIn() async {
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email.text, password: password.text);
      return true;
    } catch(e) {
      bool value = _onError(e.toString());
      return value;
    }
  }

  Future<bool> signUp() async {
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: email.text, password: password.text).then((user){
        Map<String, dynamic> values = {
          "firstname" : firstname.text,
          "lastname" : lastname.text,
          "email" : email.text,
          "id" : user.user.uid,
          "phone" : phone.text,
        };
        _userServices.createUser(values);
      });
      return true;
    } catch(e) {
      bool value = _onError(e.toString());
      return value;
    }
  }

  Future signOut() {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController(){
    firstname.text = " ";
    lastname.text = " ";
    password.text = " ";
    email.text = " ";
    phone.text = " ";
  }

  bool _onError(String error) {
    _status = Status.Unauthenticated;
    notifyListeners();
    print("We got an error: $error");
    return false;
  }
}