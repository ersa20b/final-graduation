import 'package:flutter/material.dart';
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
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    'skip',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    
                ),
               const SizedBox(height: 20),
               SplashText(text: 'Easy Scheduling and Tracking', fontSize: 42.0),
               const SizedBox(height: 20),
                Circle(image: 'assets/images/second.png'),
                const SizedBox(height: 20),
                 SplashText(text: 'Receive reminders exactly when you need them.', fontSize: 20.0),
                 const SizedBox(height: 30),
                Center(child: SplashBotton(text: 'Next', color: Colors.white,onTap: () {
                  Navigator.pushNamed(context, '/thirdsplash');
                
                },))
              ],
            ),
          ),
        ),
      ),
    );
  }
}