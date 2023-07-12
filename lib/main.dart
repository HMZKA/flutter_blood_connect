import 'package:flutter/material.dart';
import 'package:flutter_blood_connect/components.dart';
import 'package:flutter_blood_connect/donation_screen.dart';
import 'package:flutter_blood_connect/home_screen.dart';
import 'package:flutter_blood_connect/profile_screen.dart';

import 'login_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: getMaterialColor(Colors.red.shade300)),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
