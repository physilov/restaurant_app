import 'package:flutter/material.dart';
import 'package:restaurant_app/src/helpers/change_screen_helper.dart';
import 'package:restaurant_app/src/models/products.dart';
import 'package:restaurant_app/src/provider/product.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/src/screens/details.dart';
import 'package:transparent_image/transparent_image.dart';

import 'custom_text.dart';
import 'loading.dart';

class FeaturedWidget extends StatefulWidget {
  final ProductModel product;

  const FeaturedWidget({Key key, this.product}) : super(key: key);
  @override
  _FeaturedWidgetState createState() => _FeaturedWidgetState();
}

class _FeaturedWidgetState extends State<FeaturedWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final productProvider = Provider.of<ProductProvider>(context);

    return Container(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
          itemCount: productProvider.products.length,
          itemBuilder: (_, index){
          return Padding(
            padding: EdgeInsets.fromLTRB(12, 14, 16, 12),
            child: GestureDetector(
              onTap: (){
                changeScreen(context, Details(product: productProvider.products[index],));
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
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Loading(),
                      ),
                    ),
                    Center(
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: productProvider.products[index].image,
                        height: 146,

                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CustomText(
                            text: productProvider.products[index].name,
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
                            /*   child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: productsList[index]
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
                                  ),*/
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: CustomText(
                                text: productProvider.products[index].rating.toString(),
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
                            text: "\$${productProvider.products[index].price / 100}",
                            weight: FontWeight.bold,
                            colors: Colors.red,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),


          );
          }
      ),
    );
  }
}