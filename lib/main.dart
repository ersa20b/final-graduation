import 'package:flutter/material.dart';

import 'package:graduation_med_/pages/home_page.dart';

import 'package:graduation_med_/providers/auth_provider.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: HomePage(),

      

      
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
/* initialRoute: '/',
      routes: {
         '/': (context) => OnBoardingScreen(),
          '/secondsplash': (context) => SecondScreen(),
           '/thirdsplash': (context) =>ThirdScreen(),
         '/login':(context)=>const SigninPage(),
        '/signup':(context)=>const SignupPage(),
         '/main': (context) => const HomePage(), 
         '/setting1':(context)=>const Setting1(),
         '/setting2':(context)=>const Setting2(),



      }*/
        );
        
      
    
  }
}