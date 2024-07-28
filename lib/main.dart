import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/Theme.dart';
import 'package:todo/home/Home_Screen.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:HomeScreen.routeName ,
      routes: {
        HomeScreen.routeName : (context)=>HomeScreen(),
      },
      theme: ThemeDatamain.lightTheme,
    );
  }
}
