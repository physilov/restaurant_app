import 'package:flutter/material.dart';
import 'package:restaurant_app/src/models/products.dart';
import 'package:restaurant_app/src/widgets/custom_text.dart';

import 'package:restaurant_app/src/screens/details.dart';
import 'package:restaurant_app/src/widgets/featured_products.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {

  Product product =  Product(
      name: "Pork Momo",
      price: 14.99,
      rating: 4.2,
      vendor: "GoodFos",
      wishList: true,
      image: "momo.png");

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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 120,
              width: MediaQuery.of(context).size.width - 10,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.red[500],
                    offset: Offset(3, 5),
                    blurRadius: 30,
                  )
                ]
              ),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "images/${product.image}",
                      height: 100,
                      width: 100,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RichText(text: TextSpan(children: [
                        TextSpan(text: product.name + "\n", style: TextStyle(color: Colors.black, fontSize: 20)),
                        TextSpan(text: "\$" + product.price.toString(), style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                      ]
                      ),),

                      IconButton(icon: Icon(Icons.delete, color: Colors.red,), onPressed: null,)
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
