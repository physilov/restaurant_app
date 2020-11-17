import 'package:flutter/material.dart';
import 'package:restaurant_app/src/widgets/custom_text.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.red),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(text: "Shopping Bag",),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.red, size: 30,),
                ),
              ),
              Positioned(
                left: 35,
                top: 30,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(2,1),
                            blurRadius: 3,
                          )
                        ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: CustomText(text: "2", colors: Colors.red, size: 10, weight: FontWeight.bold,),
                    )),
              ),
            ],
          ),
        ],

      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width - 10,
            decoration: BoxDecoration(
              color: Colors.red,
              boxShadow: [
                BoxShadow(
                  color: Colors.red,
                  offset: Offset(3, 2),
                )
              ]
            ),
          )
        ],
      ),
    );
  }
}
