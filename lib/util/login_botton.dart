import 'package:flutter/material.dart';

class LoginBotton extends StatelessWidget {
  final String text;
  final Color color;
  final Function()? onTap;
  const LoginBotton({super.key,required this.text, required this.color,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     onTap: onTap,
      child: Container(
      
        height: 75,
        width: 390,
        
        
        decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(25)
        ),
        child: Center(
          child: Text(
            text,
            style:  TextStyle(color:Theme.of(context).colorScheme.onPrimary,fontSize: 22,fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

  }
}
  