import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final String image;
  const Circle({super.key,required this.image});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 329,
        width: 329,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(160),
          //color: Color(0xff75B6C2)
          color: Theme.of(context).colorScheme.secondary

        ),
        child: Image.asset(image,height: 50,width:50,),
      ),
    );
  }
}