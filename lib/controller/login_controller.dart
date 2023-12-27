import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qulip/apis/api_repository.dart';
import 'package:qulip/common/snack.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/controller/base_controller.dart';
import 'package:qulip/models/login/login_model.dart';
import 'package:qulip/models/login/user_db_model_.dart';
import 'package:qulip/routes/app_routes.dart';
import 'package:qulip/utils/storage_helper.dart';

class LoginController extends BaseController {
  static LoginController get instance => Get.find();

  final txtPhone = TextEditingController();
  final txtPassword = TextEditingController();
  String otpController = '';
  final userData = LoginModel().obs;
  final isRemember = false.obs;
  final counter = 30.obs;
  late Timer timer;

  final txtProfileAccount = TextEditingController();
  final txtProfilePassword = TextEditingController();
  final txtProfileName = TextEditingController();
  final txtProfileEmail = TextEditingController();
  final txtProfileAddress = TextEditingController();
  final txtProfileAffiUId = TextEditingController();

  final _db = FirebaseFirestore.instance;

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

  Future<void> setRemembered() async {
    txtPhone.text = await StorageHelper.read(StorageKeys.phoneNumber) ?? '';
    txtPassword.text = await StorageHelper.read(StorageKeys.password) ?? '';
    isRemember.value =
        await StorageHelper.read(StorageKeys.isRemember) ?? false;
  }

  void loginMobile() async {
    if (txtPhone.text.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errorMobileLbl);
      return;
    }

    if (txtPassword.text.isEmpty) {
      MySnackBar.errorSnackbar(WordStrings.errorPasswordLbl);
      return;
    }

    setLoading(true);
    if (isRemember.value == true) {
      await StorageHelper.write(StorageKeys.phoneNumber, txtPhone.text);
      await StorageHelper.write(StorageKeys.password, txtPassword.text);
      await StorageHelper.write(StorageKeys.isRemember, isRemember.value);
    } else {
      await StorageHelper.write(StorageKeys.phoneNumber, "");
      await StorageHelper.write(StorageKeys.password, "");
      await StorageHelper.write(StorageKeys.isRemember, false);
    }
    ApiRepo.loginWithMobile(
      mobile: txtPhone.text,
      password: txtPassword.text,
      onComplete: (success, response) async {
        if (success) {
          userData.value.points = response['points'];
          userData.value.link = response['link'];
          StorageHelper.write(StorageKeys.isLogin, true);
          StorageHelper.write(StorageKeys.userData, userData);
          StorageHelper.write(StorageKeys.point, response['points']);
          StorageHelper.write(StorageKeys.profileLink, response['link']);

          final userDbModel = UserDBModel(
            username: txtPhone.text,
            password: txtPassword.text,
            points: userData.value.points,
          );
          checkUserExists(userDbModel);
        } else {
          setLoading(false);
          MySnackBar.errorSnackbar(WordStrings.somethingwentWrong);
        }
      },
    );
  }

  checkUserExists(UserDBModel uModel) async {
    bool isCompleted = false;
    List<UserDBModel> list = [];
    await _db.collection('User').get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        list.add(UserDBModel(
            username: doc["UserName"],
            password: doc["Password"],
            points: doc["Points"]));

        debugPrint(
            "LoginModel inProgress >> $isCompleted >> ${doc["UserName"]} >> ${doc["Password"]} >> ${doc["Points"]} >> ${list.length}");
      }
    }).whenComplete(() => isCompleted = true);

    if (isCompleted) {
      if (list.firstWhereOrNull((it) => (it.username == uModel.username &&
              it.password == uModel.password &&
              it.points == uModel.points)) !=
          null) {
        txtPhone.clear();
        txtPassword.clear();
        Get.toNamed(AppRoutes.homeScreen);
        debugPrint('LoginModel Already exists! >> ');
      } else {
        debugPrint('LoginModel Added!');
        storeUserInDb(uModel);
      }
    }
  }

  //FireStore method
  storeUserInDb(UserDBModel uModel) async {
    await _db
        .collection("user")
        .add(uModel.toJson())
        .then((value) => StorageHelper.write(StorageKeys.userId, value.id))
        .whenComplete(() {
      txtPhone.clear();
      txtPassword.clear();
      Get.toNamed(AppRoutes.homeScreen);
    });
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
