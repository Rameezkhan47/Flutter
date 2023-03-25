import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final deviceSize = MediaQuery.of(context).size;
     final deviceSize = Get.size;

    return Scaffold(
        body: Lottie.asset(
      'assets/splash.json',
      height: deviceSize.height * 1,
      width: double.infinity,
    ));
  }
}
