import 'package:flutter/material.dart';
import 'package:graduation_med_/util/circle.dart';

import 'package:graduation_med_/util/splash_botton.dart';
import 'package:graduation_med_/util/splash_text.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    
                },
                  child: 
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text('skip',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),))),
                const SizedBox(height: 20),
               SplashText(text: 'Stay Healthy and Organized', fontSize: 42.0),
               const SizedBox(height: 20),
                Circle(image: 'assets/images/first.png'),
                const SizedBox(height: 20),
                 SplashText(text: 'Track medications for yourself and family members in one place.', fontSize: 20.0),
                const SizedBox(height: 30),
                
                Center(child: SplashBotton(text: 'Next', color: Colors.white,onTap:() {
                  Navigator.pushNamed(context, '/secondsplash');
                } ,))
              ],
            ),
          ),
        ),
      ),
    );
  }
}