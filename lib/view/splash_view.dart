import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    // Using Future.delayed instead of Timer.periodic
    Future.delayed(const Duration(seconds: 30000), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => Placeholder(), // Replace with your desired widget
        ),
            (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: // Load a Lottie file from your assets
        Lottie.asset('assets/splash.json', height: 200, width: 200),
      ),
    );
  }
}
