import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qulip/routes/app_routes.dart';
import 'package:qulip/utils/storage_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> nextScreen() async {
    final isLogin = await StorageHelper.read(StorageKeys.isLogin);
    Timer(
        const Duration(seconds: 3),
        () => {
              if (isLogin != null && isLogin)
                {Get.toNamed(AppRoutes.homeScreen)}
              else
                {Get.toNamed(AppRoutes.loginScreen)}
            });

    // Future.delayed(const Duration(seconds: 3), () {
    //   SchedulerBinding.instance.addPostFrameCallback((_) {
    //     if (isLogin) {
    //       Get.toNamed(AppRoutes.homeScreen);
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
