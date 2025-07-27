import 'package:flutter/material.dart';
import 'package:graduation_med_/pages/addme10.dart';
import 'package:graduation_med_/pages/addmed14.dart';
import 'package:graduation_med_/pages/addmed13.dart';
import 'package:graduation_med_/pages/addmed18.dart';
import 'package:graduation_med_/pages/addmed19.dart';
import 'package:graduation_med_/pages/addmed12.dart';
import 'package:graduation_med_/pages/addmed15.dart';
import 'package:graduation_med_/pages/addmed16.dart';
import 'package:graduation_med_/pages/addmed17.dart';
import 'package:graduation_med_/pages/addmed9.dart';
import 'package:graduation_med_/pages/on_boarding_screen.dart';


import 'pages/home_page.dart';




void main(){
   print('App Started');
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PuffCount(),
      
       //---------------------------
  theme: ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    surface:Color(0xff93D5E1),
    onSurface: Colors.black,
    primary: Color(0xFF2196F3),        
    onPrimary: Colors.white,           
    secondary: Color(0xFF75B6C2),      
    onSecondary: Colors.black,                 
    error: Colors.red,                
    onError: Colors.white,  
              
  ),
),
//------------------------
 //initialRoute: '/',
      routes: {
       '/main': (context) => const HomePage(), 
      }
        );
        
      
    
  }
}