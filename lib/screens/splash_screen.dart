import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/homepage.dart'; 
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMainPage();
  }

  // Navigate to MainPage after 3 seconds
  void _navigateToMainPage() {
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Mainpage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Lottie.asset('assets/movie.json'), // Lottie animation
      ),
    );
  }
}
