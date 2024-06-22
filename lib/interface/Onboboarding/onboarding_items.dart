
 import 'dart:ui';

import 'package:lottie/lottie.dart';

import 'onboarding_info.dart';

class OnboardingItems{
  List<OnboardingInfo> items = [
    OnboardingInfo(
        title: "Our APP",
        descriptions: "House Fire provides you with a safe life in your home and also provides you with facilities for dealing with the gas company.",
        image:"assets/splash.png",
        ),


    OnboardingInfo(
        title: "Warning",
        descriptions: "The application can send alerts in cases of danger or when both the gas sensor and flame sensor exceed normal values .",
        image: "assets/12083537_Wavy_Bus-22_Single-05.jpg"),

    OnboardingInfo(
        title: "Showing Bills",
        descriptions: "When the gas company sends your gas bills, you can inquire about them through the application.",
        image: "assets/12219242_4911345.jpg"),

    OnboardingInfo(
        title: "Consumption Rate",
        descriptions: "The App will show Consumption Rate of Gas Sensor and values are changed automatically .",
        image: "assets/23991117_6895861.jpg"),

  ];
 }