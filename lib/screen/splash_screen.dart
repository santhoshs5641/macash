// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:macashh/Screen/home.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    super.initState();
    // Delay for 13 seconds before navigating to the next screen
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue, // Set background color to blue
      body: Center(
        child: Text(
          'MACASH',
          style: TextStyle(
            fontSize: 52,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Set text color to white
          ),
        ),
      ),
    );
  }
}
