import 'package:flutter/material.dart';
//import 'package:light_notes/view/home.dart';
import 'package:light_notes/view/login.dart';
//import 'package:light_notes/view/home0.dart';
//import 'package:light_notes/view/input_idea.dart';
//import 'package:light_notes/view/login.dart';
//import 'package:light_notes/view/register.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HSI Notes",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "inter",
      ),
      home: LoginPage(),
    );
  }
}