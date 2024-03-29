import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_app/src/helpers/change_screen_helper.dart';
import 'package:restaurant_app/src/models/catogery.dart';
import 'package:restaurant_app/src/provider/product.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/src/widgets/custom_text.dart';
import 'package:restaurant_app/src/widgets/loading.dart';
import 'package:restaurant_app/src/widgets/product.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:restaurant_app/src/screens/details.dart';


class CategoryScreen extends StatelessWidget {
  final CategoryModel categoryModel;

  const CategoryScreen({Key key, this.categoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Loading(),
                  )
                ),
                ClipRRect(
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: categoryModel.image,
                      height: 160,
                      fit: BoxFit.fill,
                      width: double.infinity,

                    ),

                ),
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.05),
                        Colors.black.withOpacity(0.025),
                      ],
                    )
                  ),
                ),
                Positioned.fill(
                  bottom: 20,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomText(text: categoryModel.name, colors: Colors.white, size: 26, weight: FontWeight.bold,),
                  ),
                ),
                Positioned.fill(
                  top: 5,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black.withOpacity(0.2)
                          ),
                          child: Icon(Icons.close, color: Colors.white,),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Column(
              children: productProvider.productsByCategory.map((item) => GestureDetector(
                onTap: () {
                  changeScreen(context, Details(product: item,));
                },
                child: ProductWidget(
                  product: item,
                ),
              ))

                  .toList(),
            )

            ]

        )

      ),
    );
  }
}