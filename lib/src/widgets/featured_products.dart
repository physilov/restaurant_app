import 'package:flutter/material.dart';
import 'package:restaurant_app/src/helpers/change_screen_helper.dart';
import 'package:restaurant_app/src/models/products.dart';
import 'package:restaurant_app/src/screens/details.dart';

import 'custom_text.dart';

List<Product> productsList = [
  Product(
      name: "Pork Momo",
      price: 14.99,
      rating: 4.2,
      vendor: "GoodFos",
      wishList: true,
      image: "momo.png"),
  Product(
      name: "Tangy Spicy Ribs",
      price: 8.99,
      rating: 4.3,
      vendor: "GoodFos",
      wishList: false,
      image: "appetizer.png"),
  Product(
      name: "Shaphale",
      price: 7.99,
      rating: 4.5,
      vendor: "GoodFos",
      wishList: true,
      image: "shaphale.PNG"),
];

class Featured extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productsList.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(12, 14, 16, 12),
              child: GestureDetector(
                onTap: (){
                  changeScreen(context, Details(product: productsList[index],));
                },
                child: Container(
                  height: 220,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red[50],
                        offset: Offset(15, 5),
                        blurRadius: 30,
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "images/${productsList[index].image}",
                        height: 140,
                        width: 140,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              text: productsList[index].name,
                            ),
                          ),
                          //  SizedBox(height: 4.0,),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[300],
                                    offset: Offset(1, 1),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: productsList[index].wishList
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 18,
                                      )
                                    : Icon(
                                        Icons.favorite_border,
                                        color: Colors.red,
                                        size: 18,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: CustomText(
                                  text: productsList[index].rating.toString(),
                                  colors: Colors.grey,
                                  size: 14,
                                ),
                              ),
                              SizedBox(
                                width: 2.0,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.red,
                                size: 16,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.red,
                                size: 16,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.red,
                                size: 16,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.red,
                                size: 16,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.grey,
                                size: 16,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CustomText(
                              text: "\$${productsList[index].price}",
                              weight: FontWeight.bold,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
