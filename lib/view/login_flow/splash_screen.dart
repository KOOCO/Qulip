import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qulip/view/login_flow/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> nextScreen() async {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen())));

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
