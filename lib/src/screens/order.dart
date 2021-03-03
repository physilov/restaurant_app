import 'package:flutter/material.dart';
import 'package:restaurant_app/src/models/order.dart';
import 'package:restaurant_app/src/provider/auth.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/src/widgets/custom_text.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: CustomText(text: "Orders"),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          }
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemCount: authProvider.orders.length,
          itemBuilder: (_, index){
            OrderModel _order = authProvider.orders[index];
            return ListTile(
              leading: CustomText(
                text: "\$${_order.total /100}",
                weight: FontWeight.bold,
              ),
              title: Text(_order.description),
              subtitle: Text(DateTime.fromMicrosecondsSinceEpoch(_order.createdAt).toString()),
              trailing: CustomText(text: _order.status, colors: Colors.green,),
            );
          },
      ),
    );

  }
}