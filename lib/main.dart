
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/src/provider/app.dart';
import 'package:restaurant_app/src/provider/auth.dart';
import 'package:restaurant_app/src/provider/category.dart';
import 'package:restaurant_app/src/provider/product.dart';
import 'package:restaurant_app/src/screens/home.dart';
import 'package:restaurant_app/src/screens/login.dart';
import 'package:restaurant_app/src/screens/cartScreen.dart';

import 'package:restaurant_app/src/screens/splash.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AuthProvider.initialize()),
    ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
    ChangeNotifierProvider.value(value: ProductProvider.initialize()),
    ChangeNotifierProvider.value(value: AppProvider()),

  ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: ScreenController(),
    ),
  ));
}

class ScreenController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    switch(auth.status){
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return Home();
      default: return LoginScreen();
    }

  }
}