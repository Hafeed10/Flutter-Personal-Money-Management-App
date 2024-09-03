import 'package:flutter/material.dart';
import 'package:personal_money_management_app/screens/home/screen_home.dart';

void main() {
  runApp(const  MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Management',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3:false,
      ),
      home: const ScreenHome()
    );
  }
}

