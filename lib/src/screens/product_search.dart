import 'package:flutter/material.dart';
import 'package:restaurant_app/src/helpers/change_screen_helper.dart';
import 'package:restaurant_app/src/provider/product.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/src/screens/details.dart';
import 'package:restaurant_app/src/widgets/custom_text.dart';
import 'package:restaurant_app/src/widgets/product.dart';

class ProductSearchScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final productProvider = Provider.of<ProductProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.close), onPressed: (){
          Navigator.pop(context);
        },),
        title: CustomText(text: "Products", size: 20,),
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){
            
          })
        ],
      ),
      body: productProvider.productsSearched.length < 1? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search, color: Colors.grey, size: 30,),
            ],
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(text: "No products found", colors: Colors.grey, weight: FontWeight.w300, size: 22,),
            ],
          )
          
        ],
        
      ): ListView.builder(
         itemCount: productProvider.productsSearched.length,
         itemBuilder: (context, index){
           return GestureDetector(
             onTap: ()async {
               changeScreen(context, Details(product: productProvider.productsSearched[index]));
             },
             child: ProductWidget(product: productProvider.productsSearched[index],),
           );
         },
      )
    );
  }
}