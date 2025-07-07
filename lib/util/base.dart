import 'package:flutter/material.dart';

class Base extends StatelessWidget {
  const Base({super.key, required Padding child});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        SizedBox(
          height:300,
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