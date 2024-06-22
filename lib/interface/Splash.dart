import 'dart:async';

import 'package:flutter/material.dart';



import 'Onboboarding/onboarding_view.dart';



class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      timer.cancel();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) => const OnboardingView() ),
              (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/splash.png", height: 300, width: 300)
        
        // Load a Lottie file from your assets
       // Lottie.asset('assets/_Fire Flame Logo design (1).png', height: 20, width: 20),
      ),

    );
  }
}


