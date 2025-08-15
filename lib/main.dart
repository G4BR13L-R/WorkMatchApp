import 'package:flutter/material.dart';
import 'package:work_match_app/ui/screens/auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Work Match',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber, fontFamily: 'Roboto'),
      home: const LoginScreen(),
    );
  }
}
