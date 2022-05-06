import 'package:flutter/material.dart';
import 'dart:async';
import '../home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState(){
    super.initState();
    Timer(
        const Duration(seconds: 2),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const HomePage())));

  }
  @override
  Widget build(BuildContext context) {
    var sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xfff7e5cf),
      body: Center(
        child: Image.asset(
          'assets/splash_screen.png',
          width: sizeScreen.width * 0.25,
          height: sizeScreen.width * 0.25,
        ),
      ),
    );
  }
}
