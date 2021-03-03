import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/src/helpers/change_screen_helper.dart';
import 'package:restaurant_app/src/models/products.dart';
import 'package:restaurant_app/src/provider/auth.dart';
import 'package:restaurant_app/src/provider/product.dart';
import 'package:restaurant_app/src/screens/details.dart';
import 'package:restaurant_app/src/widgets/featured.dart';
import 'package:restaurant_app/src/widgets/loading.dart';
import 'package:restaurant_app/src/widgets/product.dart';
import 'package:transparent_image/transparent_image.dart';

import 'custom_text.dart';


class Featured extends StatefulWidget {
  @override
  _FeaturedState createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Container(
      height: 240,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12, 14, 16, 12),
        child: Column(
          children: productProvider.featuredProducts.map((item) => GestureDetector(
            onTap: (){
              changeScreen(context, Details(product: item,));
            },
            child: FeaturedWidget(
              product: item,
            ),
          ))
              .toList(),
          /*      GestureDetector(
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
                                image: productProvider.featuredProducts[index].image,
                                height: 146,

                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomText(
                                  text: productProvider.featuredProducts[index].name,
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
                                      text: productProvider.featuredProducts[index].rating.toString(),
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
                                  text: "\$${productProvider.featuredProducts[index].price}",
                                  weight: FontWeight.bold,
                                  colors: Colors.red,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ), */

        ),
      )
    );
  }
}
