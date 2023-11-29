import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qulip/apis/api_repository.dart';
import 'package:qulip/common/snack.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/controller/base_controller.dart';
import 'package:qulip/models/login_model.dart';
import 'package:qulip/utils/storage_helper.dart';

class LoginController extends BaseController {
  final txtPhone = TextEditingController();
  final txtPassword = TextEditingController();
  String otpController = '';
  final userData = LoginModel().obs;
  final isRemember = false.obs;
  final counter = 30.obs;
  late Timer timer;

  String formatHHMMSS(int seconds) {
    final int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    final int minutes = (seconds / 60).truncate();

    final String hoursStr = (hours).toString().padLeft(2, '0');
    final String minutesStr = (minutes).toString().padLeft(2, '0');
    final String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return '$minutesStr:$secondsStr';
    }

    return '$hoursStr:$minutesStr:$secondsStr';
  }

  void startTimer() {
    counter.value = 30;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter.value > 0) {
        counter.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void loginMobile() async {
    if (txtPhone.text.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errorMobileLbl);
      return;
    }

    // if (txtPhone.text.length < 10) {
    //   MySnackBar.errorSnackbar(WordStrings.errorValidMobileLbl);
    //   return;
    // }

    if (txtPassword.text.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errorPasswordLbl);
      return;
    }

    // if (txtPassword.text.length < 8 || txtPassword.text.length >= 16) {
    //   MySnackBar.errorSnackbar(WordStrings.errorValidPasswordLbl);
    //   return;
    // }

    setLoading(true);
    if (isRemember.value == true) {
      await StorageHelper.write(StorageKeys.phoneNumber, txtPhone.text);
      await StorageHelper.write(StorageKeys.password, txtPhone.text);
    }
    ApiRepo.loginWithMobile(
      mobile: txtPhone.text,
      password: txtPassword.text,
      onComplete: (success, response) async {
        setLoading(false);
        if (success) {
          userData.value.mobile = response['data']['mobile'];
        } else {}
      },
    );
  }

  void getPoints(String mobile) {
    setLoading(true);
    ApiRepo.getPoints(
      phone: mobile,
      onComplete: (success, response) async {
        setLoading(false);
        if (success) {
          MySnackBar.successSnackbar(response['message']);
        }
      },
    );
  }
}
