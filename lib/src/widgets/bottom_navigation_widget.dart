import 'package:flutter/material.dart';

import 'custom_text.dart';

class BottomNavigationWidget extends StatelessWidget {
  final IconData icon;
  final String name;

  const BottomNavigationWidget({Key key, this.icon, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Icon(icon, size: 30,),
          SizedBox(height: 2.0,),
          CustomText(text: name,),
        ],
      ),
      //child: Image.asset("images/appetizer.PNG", width: 26, height: 26,),
    );
  }
}
