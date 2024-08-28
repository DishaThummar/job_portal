import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/configs/app_images.dart';
import 'package:job_portal/view/splash/controller/splash_controller.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SplashController(),
        builder: (controller) {
          return Scaffold(
            body: Center(
              child: Lottie.asset(AppImages.splash, height: 250, width: 250),
            ),
          );
        });
  }
}
