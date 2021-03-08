import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/src/helpers/change_screen_helper.dart';
import 'package:restaurant_app/src/provider/app.dart';
import 'package:restaurant_app/src/provider/auth.dart';

import 'package:restaurant_app/src/provider/category.dart';
import 'package:restaurant_app/src/provider/product.dart';
import 'package:restaurant_app/src/screens/cart.dart';
import 'package:restaurant_app/src/screens/login.dart';
import 'package:restaurant_app/src/screens/order.dart';
import 'package:restaurant_app/src/screens/product_search.dart';
import 'package:restaurant_app/src/widgets/bottom_navigation_widget.dart';
import 'package:restaurant_app/src/widgets/categories.dart';

import 'package:restaurant_app/src/widgets/custom_text.dart';
import 'package:restaurant_app/src/widgets/featured.dart';
import 'package:restaurant_app/src/widgets/loading.dart';

import 'category.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);


    return Scaffold(

      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.1,
        backgroundColor: Colors.purple,
        title: CustomText(text: "FoodApp",),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){
                changeScreen(context, ShoppingCart());
              }),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)
                  ),

                ),
              ),
            ],
          ),

        ],

      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.purple,
                ),
                //currentAccountPicture: Image.network(authProvider.user.photoURL),
                accountName: Text(
                  '${authProvider.user.displayName}'
                ),
                accountEmail: CustomText(text: authProvider.user.email)),

            ListTile(
              onTap: (){
                changeScreen(context, Home());
              },
              leading: Icon(Icons.home),
              title: CustomText(text: "Home",),
            ),

            ListTile(
              onTap: () async{
                await authProvider.getOrders();
                changeScreen(context, OrderScreen());
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(text: "My orders",),
            ),
            ListTile(
              onTap: () async{
                changeScreen(context, ShoppingCart());
              },
              leading: Icon(Icons.shopping_cart),
              title: CustomText(text: "Cart",),
            ),
            ListTile(
              onTap: ()  {
                authProvider.signOut();
              //  authProvider.clearController();
                changeScreenReplacement(context, LoginScreen());
               // Navigator.pop(context);
              },
              leading: Icon(Icons.exit_to_app),
              title: CustomText(text: "Log Out",),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: <Widget>[

            Container(
              color: Colors.purple,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        offset: Offset(1, 1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Icon(Icons.search, color: Colors.purple),
                    title: TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (pattern)async{
                        appProvider.changeLoading();
                        await productProvider.search(productName: pattern);
                        changeScreen(context, ProductSearchScreen());
                        appProvider.changeLoading();

                      },
                      decoration: InputDecoration(
                          hintText: "Find your food",
                          border: InputBorder.none
                      ),
                    ),
                    trailing: Icon(Icons.filter_list, color: Colors.purple),
                  ),
                ),
              ),
            ),

            //navigation bar



            SizedBox(height: 5.0,),

            // search box after navigation bar



            SizedBox(height: 5.0,),

            //Categories(),
            Container(
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryProvider.categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
         //                     appProvider.changeLoading();
                        await productProvider.loadProductsByCategory(
                            categoryName: categoryProvider.categories[index].name);

                        changeScreen(
                            context,
                            CategoryScreen(
                              categoryModel:
                              categoryProvider.categories[index],
                            ));

   //                           appProvider.changeLoading();

                      },
                      child: Categories(
                        category: categoryProvider.categories[index],
                      ),
                    );
                  }),
            ),

            SizedBox(height: 5.0,),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(text: "Featured", size: 20, colors: Colors.grey,),
            ),

            FeaturedWidget(),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(text: "Popular", size: 20, colors: Colors.grey,),
            ),

      /*      Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 200,
                          width: 400,
                          child: Image.asset("images/momo.png", fit: BoxFit.fill,)),
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
                              Text("4.5")
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
                          TextSpan(text: "Pancakes \n", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                          TextSpan(text: "by ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: Colors.white)),
                          TextSpan(text: "Pizza hut", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),

                        ], style: TextStyle(color: Colors.black)
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(text: TextSpan(children: [
                          TextSpan(text: "\$12.99 \n", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300, color: Colors.white)),

                        ], style: TextStyle(color: Colors.black)),),
                      )
                    ],
                  ),
                ))

              ],
            ), */







          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            BottomNavigationWidget(
              onTap: (){
                changeScreen(context, Home());
              },
              icon: Icons.home,
              name: "Home",
            ),
            BottomNavigationWidget(
              onTap: (){
                changeScreen(context, ShoppingCart());
              },
              icon: Icons.restaurant_menu,
              name: "Menu",
            ),
            BottomNavigationWidget(
              onTap: (){
                changeScreen(context, ShoppingCart());
              },
              icon: Icons.shopping_cart,
              name: "Cart",
            ),
            BottomNavigationWidget(
              onTap: (){
                changeScreen(context, ShoppingCart());
              },
              icon: Icons.account_box,
              name: "Profile",
            ),

          ],
        ),
      ),
    );
  }
}