import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() {
  runApp(const BookHairApp());
}

class BookHairApp extends StatelessWidget {
  const BookHairApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookHair',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
