import 'package:flutter/material.dart';

class SplashText extends StatelessWidget {
  final String text;
  final double fontSize;
  const SplashText({super.key,required this.text,required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize: fontSize,color: Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,);
  }
}