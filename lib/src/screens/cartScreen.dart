import 'package:flutter/material.dart';
import 'package:restaurant_app/src/helpers/order.dart';
import 'package:restaurant_app/src/models/cart_item.dart';
import 'package:restaurant_app/src/provider/auth.dart';
import 'package:restaurant_app/src/provider/app.dart';

import 'package:restaurant_app/src/widgets/custom_text.dart';
import 'package:provider/provider.dart';

import 'package:restaurant_app/src/widgets/loading.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _key = GlobalKey<ScaffoldState>();
  OrderServices _orderServices = OrderServices();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);


    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.red),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(text: "Shopping Cart",),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: (){
            Navigator.pop(context);
          },
        ),


      ),
      backgroundColor: Colors.white,
      body: appProvider.isLoading ? Loading() : ListView.builder(
        itemCount: authProvider.userModel.cart.length,
        itemBuilder: (_, index){
          return Padding(padding: const EdgeInsets.all(16),
              child:
              Container(
                height: 120,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red[500],
                        offset: Offset(3, 5),
                        blurRadius: 30,
                      )
                    ]
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        authProvider.userModel.cart[index].image,
                        height: 120,
                        width: 140,
                        fit: BoxFit.fill,
                      ),
                    ),

                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RichText(text: TextSpan(children: [
                            TextSpan(text: authProvider.userModel.cart[index].name + "\n", style: TextStyle(color: Colors.black, fontSize: 20)),
                            TextSpan(text:  "\$${authProvider.userModel.cart[index].price}  \n", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                            TextSpan(text: "Quantity: ", style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400)),
                            TextSpan(text: authProvider.userModel.cart[index].quantity.toString(), style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400)),

                          ]
                          ),),

                          IconButton(
                              icon: Icon(Icons.delete, color: Colors.red,),
                              onPressed: ()async{
                                appProvider.changeLoading();
                                bool value = await authProvider.removeFromCart(cartItem: authProvider.userModel.cart[index]);
                                if(value){
                                  authProvider.reloadUserModel();
                                  print("Item added to cart");
                                  _key.currentState.showSnackBar(SnackBar(content: Text("Removed from Cart!")));
                                  appProvider.changeLoading();
                                  return;
                                }else{
                                  print("Item was not removed");
                                  appProvider.changeLoading();
                                }
                              }
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )

          );
        },

      ),
      bottomNavigationBar: Container(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(text: TextSpan(children: [
                TextSpan(
                    text: "Total: ",
                    style: TextStyle(color: Colors.grey, fontSize: 22, fontWeight: FontWeight.w400)
                ),
                TextSpan(
                    text: "\$${authProvider.userModel.totalCartPrice}",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 22,
                        fontWeight: FontWeight.normal
                    )
                ),
              ])),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: Colors.grey
                ),
                child: FlatButton(
                  onPressed: (){
                    if(authProvider.userModel.totalCartPrice == 0){
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Container(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Your cart is empty', textAlign: TextAlign.center,),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                      );
                      return;
                    }
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Container(
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('You will be charged \$${authProvider.userModel.totalCartPrice}', textAlign: TextAlign.center,),
                                    SizedBox(
                                      width: 320.0,
                                      child: RaisedButton(
                                        onPressed: ()async{
                                          var uuid = Uuid();
                                          String id = uuid.v4();
                                          _orderServices.createOrder(
                                              userId: authProvider.user.uid,
                                              id: id,
                                              description: "Some random description",
                                              status: "complete",
                                              totalPrice: authProvider.userModel.totalCartPrice,
                                              cart: authProvider.userModel.cart
                                          );
                                          for(CartItemModel cartItem in authProvider.userModel.cart){
                                            bool value = await authProvider.removeFromCart(cartItem: cartItem);
                                            if(value){
                                              authProvider.reloadUserModel();
                                              print("Item addded to cart");
                                              _key.currentState.showSnackBar(
                                                  SnackBar(content: Text("Removed from Cart!"))
                                              );
                                            }else{
                                              print("ITEM WAS NOT REMOVED");
                                            }
                                          }
                                          _key.currentState.showSnackBar(
                                              SnackBar(content: Text("Order created!"))
                                          );
                                          Navigator.pop(context);

                                        },
                                        child: Text(
                                          "Accept",
                                          style: TextStyle(color: Colors.white
                                          ),
                                        ),
                                        color: const Color(0xFF1BC0C5),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 320.0,
                                      child: RaisedButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Reject",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                    );
                  },
                  child: CustomText(
                    text: "Check out",
                    size: 20,
                    colors: Colors.white,
                    weight: FontWeight.normal,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
