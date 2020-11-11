import 'package:flutter/material.dart';
import 'package:restaurant_app/src/models/catogery.dart';

import 'custom_text.dart';

List<Category> categoriesList = [
  Category(name: "Appetizer", image: "appetizer.PNG"),
  Category(name: "Soup & Salads", image: "soupnsalad.png"),
  Category(name: "Tandoori Plates", image: "appetizer.PNG"),
  Category(name: "House Special", image: "appetizer.PNG"),
  Category(name: "Classic Curries", image: "appetizer.PNG"),
];

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesList.length,
        itemBuilder: (_, index){
          return Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.red[50],
                          offset: Offset(4, 6),
                          blurRadius: 20
                      )
                    ],

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset("images/${categoriesList[index].image}",width: 60,height: 60, fit: BoxFit.fill, colorBlendMode: BlendMode.clear,),
                  ),

                ),
                SizedBox(height: 5.0,),
                CustomText(text: categoriesList[index].name, size: 11, colors: Colors.black,)


              ],
            ),
          );
        },
      ),
    );
  }
}
