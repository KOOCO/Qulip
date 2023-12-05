import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qulip/controller/base_controller.dart';
import 'package:qulip/models/login_model.dart';

class ProfileController extends BaseController {
  final txtAccount = TextEditingController();
  final txtPassword = TextEditingController();
  final txtName = TextEditingController();
  final txtEmail = TextEditingController();
  final txtAddress = TextEditingController();
  final txtAffiUId = TextEditingController();

  final userData = LoginModel().obs;

  // void loginMobile() async {
  //   if (txtPhone.text.isEmpty) {
  //     MySnackBar.errorSnackbar(WordStrings.errorMobileLbl);
  //     return;
  //   }

  //   // if (txtPhone.text.length < 10) {
  //   //   MySnackBar.errorSnackbar(WordStrings.errorValidMobileLbl);
  //   //   return;
  //   // }

  //   if (txtPassword.text.isEmpty) {
  //     MySnackBar.errorSnackbar(WordStrings.errorPasswordLbl);
  //     return;
  //   }

  //   // if (txtPassword.text.length < 8 || txtPassword.text.length >= 16) {
  //   //   MySnackBar.errorSnackbar(WordStrings.errorValidPasswordLbl);
  //   //   return;
  //   // }

  //   setLoading(true);
  //   if (isRemember.value == true) {
  //     await StorageHelper.write(StorageKeys.phoneNumber, txtPhone.text);
  //     await StorageHelper.write(StorageKeys.password, txtPhone.text);
  //   }
  //   ApiRepo.loginWithMobile(
  //     mobile: txtPhone.text,
  //     password: txtPassword.text,
  //     onComplete: (success, response) async {
  //       setLoading(false);
  //       if (success) {
  //         userData.value.mobile = response['data']['mobile'];
  //         Get.toNamed(AppRoutes.homeScreen);
  //       } else {}
  //     },
  //   );
  // }

  // void getPoints(String mobile) {
  //   setLoading(true);
  //   ApiRepo.getPoints(
  //     phone: mobile,
  //     onComplete: (success, response) async {
  //       setLoading(false);
  //       if (success) {
  //         MySnackBar.successSnackbar(response['message']);
  //       }
  //     },
  //   );
  // }
}
