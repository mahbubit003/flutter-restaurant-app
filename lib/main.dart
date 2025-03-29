import 'package:flutter/material.dart';
import 'package:restaurant_app/pages/home.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      // darkTheme: ThemeData.dark(), // Dark theme
      // themeMode: ThemeMode.dark,
      home: HomePage(),
    );
  }
}