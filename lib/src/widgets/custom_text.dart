import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color colors;
  final FontWeight weight;

  CustomText({@required this.text, this.size, this.colors, this.weight});

  @override
  Widget build(BuildContext context) {
    return Text(text ?? null, style: TextStyle(fontSize: size ?? 16, color: colors ?? Colors.black, fontWeight: weight ?? FontWeight.normal),);
  }
}