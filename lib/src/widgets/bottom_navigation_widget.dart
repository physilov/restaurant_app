import 'package:flutter/material.dart';

import 'custom_text.dart';

class BottomNavigationWidget extends StatelessWidget {
  final IconData icon;
  final String name;
  final Function onTap;

  const BottomNavigationWidget({Key key, this.icon, this.name, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap ?? null,
        child: Column(
          children: <Widget>[
            Icon(icon, size: 30,),
            SizedBox(height: 2.0,),
            CustomText(text: name,),
          ],
        ),
      ),
      //child: Image.asset("images/momo.png", width: 26, height: 26,),
    );
  }
}
