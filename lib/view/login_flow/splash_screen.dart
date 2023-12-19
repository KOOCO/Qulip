import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qulip/routes/app_routes.dart';
import 'package:qulip/view/home_flow/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> nextScreen() async {
    Timer(
        const Duration(seconds: 3),
        () => Get.toNamed(AppRoutes.surveyForm2CreateScreen) );

    // final userID = await StorageHelper.read(StorageKeys.userId);
    // Future.delayed(const Duration(seconds: 1), () {
    //   SchedulerBinding.instance.addPostFrameCallback((_) {
    //     if (userID == null) {
    //       Get.toNamed(AppRoutes.loginScreen);
    //     } else {
    //       Get.toNamed(AppRoutes.loginScreen);
    //     }
    //   });
    // });
  }

  @override
  void initState() {
    super.initState();
    nextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Image.asset('assets/images/qulip_splash_logo.png'),
        ),
      ),
    );
  }
}
