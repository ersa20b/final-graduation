import 'package:flutter/material.dart';
import 'package:graduation_med_/util/circle.dart';
import 'package:graduation_med_/util/splash_botton.dart';
import 'package:graduation_med_/util/splash_text.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 30),
                SplashText(text: 'Stay on Top of Your Health', fontSize: 42.0),
                const SizedBox(height: 20),
                Circle(image: 'assets/images/third.png',),
                const SizedBox(height: 20),
                SplashText(text: 'Monitor your intake history and get notifications when it’s time to refill.', fontSize: 20.0),
                const SizedBox(height: 30),
                Center(child: SplashBotton(text: 'Start Now', color: Colors.white,onTap: () {
                  Navigator.pushNamed(context, '/login');
                },))
              ],
            ),
          ),
        ),
      ),
    );
  }
}