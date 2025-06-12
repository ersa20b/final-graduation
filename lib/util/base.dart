import 'package:flutter/material.dart';

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        SizedBox(
          height: 200,
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadiusDirectional.only(topEnd: Radius.circular(40),topStart: Radius.circular(40)),
            child: Container(
              color: Colors.white,
            ),
          ),
        )
      ],
     );
  }
}