import 'package:flutter/material.dart';



import 'pages/home_page.dart';

import 'pages/setting2.dart';




void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Setting2(),
      
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