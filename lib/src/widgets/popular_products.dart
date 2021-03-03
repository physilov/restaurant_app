import 'package:flutter/material.dart';
import 'package:restaurant_app/src/models/products.dart';
import 'package:restaurant_app/src/widgets/small_floating_button.dart';
import 'package:transparent_image/transparent_image.dart';

class PopularWidget extends StatelessWidget {
  final ProductModel products;

  const PopularWidget({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: const EdgeInsets.only(top: 2, left: 2, right: 2, bottom: 4),
      child: Stack(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                    height: 200,
                    width: 400,
                    child: FadeInImage.memoryNetwork(placeholder: kTransparentImage,
                      image: products.image,
                      height: 146,)),
              )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                SmallButton(Icons.favorite),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(Icons.star, color: Colors.yellow[900], size: 20,),
                        ),
                        Text(products.rating.toString()),
                      ],
                    ),

                  ),
                )
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.05),
                      Colors.black.withOpacity(0.025),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                  child: RichText(text: TextSpan(children: [
                    TextSpan(text: "${products.name} \n", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                    TextSpan(text: "by ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: Colors.white)),
                    TextSpan(text: "Pizza hut", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),

                  ], style: TextStyle(color: Colors.black)
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(text: TextSpan(children: [
                    TextSpan(text: "\$${products.price} \n", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300, color: Colors.white)),

                  ], style: TextStyle(color: Colors.black)),),
                )
              ],
            ),
          ))

        ],
      ),
    );
  }
}