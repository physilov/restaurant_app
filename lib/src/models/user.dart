
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  static const FIRSTNAME = "firstname";
  static const LASTNAME = "lastname";
  static const EMAIL = "email";
  static const ID = "id";
  static const PHONE = "phone";

  String _firstname;
  String _lastname;
  String _email;
  String _id;
  String _phone;

  String get firstname => _firstname;
  String get lastname => _lastname;
  String get email => _email;
  String get id => _id;
  String get phone => _phone;

  UserModel.fromSnapshot(DocumentSnapshot snapshot){
    _firstname = snapshot.data()[FIRSTNAME];
    _lastname = snapshot.data()[LASTNAME];
    _email = snapshot.data()[EMAIL];
    _id = snapshot.data()[ID];
    _phone = snapshot.data()[PHONE];
  }

}

