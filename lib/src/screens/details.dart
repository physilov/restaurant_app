
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/src/helpers/change_screen_helper.dart';
import 'package:restaurant_app/src/models/products.dart';
import 'package:restaurant_app/src/provider/app.dart';
import 'package:restaurant_app/src/provider/auth.dart';
import 'package:restaurant_app/src/provider/product.dart';
import 'package:restaurant_app/src/screens/cart.dart';
import 'package:restaurant_app/src/widgets/custom_text.dart';
import 'package:restaurant_app/src/widgets/loading.dart';
import 'package:restaurant_app/src/widgets/small_floating_button.dart';

class Details extends StatefulWidget {
  final ProductModel product;

  const Details({@required this.product});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: appProvider.isLoading ? Loading() : Column(
          children: <Widget>[
            Container(
              height: 300,
              child: Stack(
                children: <Widget>[

                  Carousel(
                    images: [
                      NetworkImage(widget.product.image),
                      NetworkImage(widget.product.image),

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
                        icon: Icon(Icons.arrow_back, color: Colors.black,),
                        onPressed: (){Navigator.pop(context);},
                      ),
                      Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: Icon(Icons.shopping_cart, color: Colors.red, size: 30,),
                              onPressed: (){
                                changeScreen(context, ShoppingCart());
                              },
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
            CustomText(text: "\$${widget.product.price / 100}", size: 18, weight: FontWeight.w400,),
            CustomText(text: "Description", size: 18, weight: FontWeight.w400,),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.product.description, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),),


            ),

            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(icon: Icon(Icons.remove, color: Colors.red, size: 32,), onPressed: (){
                    if(quantity != 1){
                      setState(() {
                        quantity -= 1;
                      });
                    }
                  },),
                ),
                GestureDetector(
                  onTap: ()async{
                    appProvider.changeLoading();
                    print("loading........");

                    bool value = await authProvider.addToCard(product: widget.product, quantity: quantity);
                    if(value){
                      print("Item added to cart");
                      _key.currentState.showSnackBar(
                        SnackBar(content: Text("Added to Cart!"))
                      );
                      authProvider.reloadUserModel();
                      appProvider.changeLoading();
                      return;
                    }else{
                      print("Item not added to cart");
                    }
                    print("Loading set to false");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    child: appProvider.isLoading ? Loading() : Padding(
                      padding: const EdgeInsets.fromLTRB(28, 12, 28, 12),
                      child: CustomText(text: "Add $quantity to Bag", colors: Colors.white, size: 24, weight: FontWeight.w600,),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(icon: Icon(Icons.add, color: Colors.red, size: 32,), onPressed: (){
                    setState(() {
                      quantity += 1;
                    });
                  },),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}

