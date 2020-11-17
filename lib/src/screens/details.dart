import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/src/models/products.dart';
import 'package:restaurant_app/src/widgets/custom_text.dart';
import 'package:restaurant_app/src/widgets/small_floating_button.dart';

class Details extends StatefulWidget {
  final Product product;

  Details({@required this.product});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              child: Stack(
                children: <Widget>[

                  Carousel(
                    images: [
                      AssetImage('images/${widget.product.image}'),
                      AssetImage('images/${widget.product.image}'),
                      AssetImage('images/${widget.product.image}'),
                    ],
                    dotBgColor: Colors.white,
                    dotColor: Colors.grey,
                    dotIncreasedColor: Colors.red,
                    dotIncreaseSize: 1.2,
                    autoplay: false,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white,),
                        onPressed: (){Navigator.pop(context);},
                      ),
                      Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: Icon(Icons.shopping_cart, color: Colors.white, size: 30,),
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
                  Positioned(
                    right: 14,
                    bottom: 60,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[400],
                            offset: Offset(2,3),
                            blurRadius: 3,
                          )
                        ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Icon(Icons.favorite, size: 16, color: Colors.red,),
                      ),
                    ),
                  )
                ],
              ),
            ),

            CustomText(text: widget.product.name, size: 24, weight: FontWeight.bold,),
            CustomText(text: "\$" + widget.product.price.toString(), size: 18, weight: FontWeight.w400,),

            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(icon: Icon(Icons.remove, color: Colors.red, size: 32,), onPressed: (){},),
                ),
                GestureDetector(
                  onTap: (){},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(28, 12, 28, 12),
                      child: CustomText(text: "Add to Bag", colors: Colors.white, size: 24, weight: FontWeight.w600,),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(icon: Icon(Icons.add, color: Colors.red, size: 32,), onPressed: (){},),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
