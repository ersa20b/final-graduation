import 'package:flutter/material.dart';
import 'package:graduation_med_/pages/home_page.dart';
import 'package:graduation_med_/pages/signin_page.dart';
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
               
               SplashText(text: 'Stay on Top of Your Health', fontSize: 42.0),
                Circle(image: 'assets/images/third.png',),
                 SplashText(text: 'Monitor your intake history and get notifications when it’s time to refill.', fontSize: 20.0),
                
                Center(child: SplashBotton(text: 'Start Now', color: Colors.white,onTap: () {
                  Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const SigninPage();
                              }
                              )
                );
                },))
              ],
            ),
          ),
        ),
      ),
    );
  }
}