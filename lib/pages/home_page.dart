import 'package:flutter/material.dart';
import 'package:graduation_med_/util/circle.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Circle(image: '',),
    );
  }
}