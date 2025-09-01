import 'package:flutter/material.dart';
import 'package:graduation_med_/on_boarding_screens/first_screen.dart';
import 'package:graduation_med_/on_boarding_screens/second_screen.dart';
import 'package:graduation_med_/on_boarding_screens/third_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        FirstScreen(),
        SecondScreen(),
        ThirdScreen()
      ],
    );
  }
}