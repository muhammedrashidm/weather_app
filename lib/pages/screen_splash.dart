import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_weather/pages/screen_home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((d) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ScreenHome()));
      });
    });
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/lottie/earth_sat.json'),
      ),
    );
  }
}
