import 'package:flutter/material.dart';
import 'package:graduation_med_/pages/on_boarding_screens/third_screen.dart';
import 'package:graduation_med_/pages/signin_page.dart';
import 'package:graduation_med_/util/circle.dart';
import 'package:graduation_med_/util/splash_botton.dart';
import 'package:graduation_med_/util/splash_text.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

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
                GestureDetector(
                  onTap: () {
                     Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const SigninPage();
                              }
                              )
                );
                  },
                  child: Text(
                    'skip',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                ),
               SplashText(text: 'Easy Scheduling and Tracking', fontSize: 42.0),
                Circle(image: 'assets/images/second.png'),
                 SplashText(text: 'Receive reminders exactly when you need them.', fontSize: 20.0),
                
                Center(child: SplashBotton(text: 'Next', color: Colors.white,onTap: () {
                  Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const ThirdScreen();
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