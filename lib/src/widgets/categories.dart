import 'package:flutter/material.dart';
import 'package:restaurant_app/src/models/catogery.dart';
import 'package:transparent_image/transparent_image.dart';

import 'custom_text.dart';

List<CategoryModel> categoriesList = [ ];

class Categories extends StatelessWidget {
  final CategoryModel category;

  const Categories({Key key, this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
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
              child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: category.image, width: 60, height: 60,),
              //Image.asset("images/${categoriesList[index].image}",width: 60,height: 60, fit: BoxFit.fill, colorBlendMode: BlendMode.clear,),
            ),

          ),
          SizedBox(height: 5.0,),
          CustomText(text: category.name, size: 11, colors: Colors.black,)


        ],
      ),
    );
  }
}
