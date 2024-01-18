import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_button.dart';
import 'package:qulip/common/widgets/my_button_with_icon.dart';
import 'package:qulip/common/widgets/my_image.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/controller/login_controller.dart';
import 'package:qulip/routes/app_routes.dart';
import 'package:qulip/utils/storage_helper.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.find<LoginController>();
  final points = 0.obs;
  final link = "".obs;
  final username = "".obs;
  final userid = "".obs;

  Future showWarning(
          BuildContext context, String message, bool isLogout) async =>
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const MyText(
                  WordStrings.exitAppTitle,
                  fontSize: 18,
                  fontColor: yasRed,
                  fontWeight: FontWeight.bold,
                ),
                content: MyText(
                  message,
                  fontSize: 14,
                  fontColor: stdBlack,
                ),
                actions: [
                  Row(
                    children: [
                      MyButton(
                        label: WordStrings.btnYes,
                        style: const TextStyle(
                          color: whiteTxt,
                          fontWeight: FontWeight.bold,
                        ),
                        height: Get.height * 0.03,
                        width: Get.width * 0.2,
                        borderRadius: 2,
                        onTap: () {
                          if (isLogout) {
                            controller.setLoading(true);
                            Timer(
                              const Duration(seconds: 2),
                              () {
                                controller.setLoading(false);
                                StorageHelper.logout();
                                Navigator.of(context).pop(true);
                                Get.offAllNamed(AppRoutes.loginScreen);
                              },
                            );
                          } else {
                            Navigator.of(context).pop(false);
                          }
                        },
                      )..paddingOnly(left: 4, right: 4),
                      const Spacer(),
                      MyButton(
                        label: WordStrings.btnNo,
                        style: const TextStyle(
                          color: whiteTxt,
                          fontWeight: FontWeight.bold,
                        ),
                        height: Get.height * 0.03,
                        width: Get.width * 0.2,
                        borderRadius: 2,
                        onTap: () => SystemNavigator.pop(),
                      ).paddingOnly(left: 4, right: 4),
                    ],
                  ).paddingOnly(left: 10, right: 10, top: 4, bottom: 10),
                ],
              ));

  @override
  Widget build(BuildContext context) {
    // getData();
    StorageHelper.read(StorageKeys.point)
        .then((value) => {points.value = value});

    StorageHelper.read(StorageKeys.userName)
        .then((value) => {username.value = value});

    StorageHelper.read(StorageKeys.userId)
        .then((value) => {userid.value = value.toString()});

    StorageHelper.read(StorageKeys.profileLink).then((value) {
      link.value = value;
    });

    return WillPopScope(
      onWillPop: () async {
        final shouldPop =
            await showWarning(context, WordStrings.exitAppMsg, false);
        return shouldPop ?? false;
      },
      child: Scaffold(
        backgroundColor: transparentGrey,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: stdwhite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(child: SizedBox()),
                    Center(
                      child: MyImage(
                        image: AssetImages.splashLogo,
                        height: 45.h,
                      ),
                    ).paddingOnly(top: Get.height * 0.05),
                    const Expanded(child: SizedBox()),
                    InkWell(
                        onTap: () {
                          showWarning(context, WordStrings.logoutAppMsg, true);
                        },
                        child: const Icon(
                          Icons.login_rounded,
                          size: 25,
                          color: yasRed,
                        ).paddingOnly(top: Get.height * 0.04, right: 10)),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const MyText(
                          WordStrings.userLblHome,
                          fontWeight: FontWeight.normal,
                          fontFamily: FontFamilyConstant.sinkinSansMedium,
                          fontSize: 12,
                          fontColor: stdgrey,
                        ),
                        Obx(() => MyText(
                              username.value,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamilyConstant.sinkinSansMedium,
                              fontSize: 14,
                              fontColor: yasRed,
                            )),
                      ]).paddingSymmetric(horizontal: 20.w),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const MyText(
                          WordStrings.pointLblHome,
                          fontWeight: FontWeight.normal,
                          fontFamily: FontFamilyConstant.sinkinSansMedium,
                          fontSize: 12,
                          fontColor: stdgrey,
                        ),
                        Obx(() => MyText(
                              "$points ${WordStrings.pointLblHome}",
                              // "${controller.userData.value.points} ${WordStrings.pointLblHome}",
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamilyConstant.sinkinSansMedium,
                              fontSize: 14,
                              fontColor: yasRed,
                            )),
                      ]).paddingSymmetric(horizontal: 20.w),
                ],
              ),
              SizedBox(
                height: Get.height * 0.08,
              ),
              MyButtonWithIcon(
                image: AssetImages.userLogo,
                label: WordStrings.profileLblHome,
                style: const TextStyle(
                  fontSize: 14,
                  color: stdBlack,
                  fontWeight: FontWeight.w500,
                ),
                decoration: const BoxDecoration(
                  color: whiteTxt,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      color: Colors.black26,
                    )
                  ],
                ),
                height: Get.height * 0.06,
                borderRadius: 2,
                onTap: () async {
                  Get.toNamed(AppRoutes.profileScreen, arguments: link.value);
                },
              ).paddingSymmetric(horizontal: 20),
              MyButtonWithIcon(
                image: AssetImages.caseNoLogo,
                label: WordStrings.caseNoLblHome,
                style: const TextStyle(
                  fontSize: 14,
                  color: stdBlack,
                  fontWeight: FontWeight.w500,
                ),
                decoration: const BoxDecoration(
                  color: whiteTxt,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      color: Colors.black26,
                    )
                  ],
                ),
                height: Get.height * 0.06,
                borderRadius: 2,
                onTap: () async {
                  Get.toNamed(AppRoutes.caseCreateScreen);
                },
              ).paddingSymmetric(horizontal: 20, vertical: 10),
              MyButtonWithIcon(
                image: AssetImages.listLogo,
                label: WordStrings.archivesLblHome,
                style: const TextStyle(
                  fontSize: 14,
                  color: stdBlack,
                  fontWeight: FontWeight.w500,
                ),
                decoration: const BoxDecoration(
                  color: whiteTxt,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      color: Colors.black26,
                    )
                  ],
                ),
                height: Get.height * 0.06,
                borderRadius: 2,
                onTap: () async {
                  Get.toNamed(AppRoutes.caseListScreen,
                      arguments: userid.value);
                },
              ).paddingSymmetric(horizontal: 20, vertical: 5),
              MyButtonWithIcon(
                image: AssetImages.infoLogo,
                label: WordStrings.systemLblHome,
                style: const TextStyle(
                  fontSize: 14,
                  color: stdBlack,
                  fontWeight: FontWeight.w500,
                ),
                decoration: const BoxDecoration(
                  color: whiteTxt,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      color: Colors.black26,
                    )
                  ],
                ),
                height: Get.height * 0.06,
                borderRadius: 2,
                onTap: () async {
                  Get.toNamed(AppRoutes.sysInfoScreen);
                },
              ).paddingSymmetric(horizontal: 20, vertical: 10),
            ],
          ),
        ),
      ),
    );
  }

  void getData() async {
    points.value = await StorageHelper.read(StorageKeys.point);
    link.value = await StorageHelper.read(StorageKeys.profileLink);
  }
}
