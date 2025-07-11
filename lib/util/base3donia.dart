import 'package:flutter/material.dart';

class Base3 extends StatelessWidget {
  final Widget child;

  const Base3({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 400),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
           
            child: child,
          ),
        ),
      ],
    );
  }
}
