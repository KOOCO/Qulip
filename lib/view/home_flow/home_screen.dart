import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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

  final controller = Get.put(LoginController());
  int points = 0;

  Future showWarning(BuildContext context) async => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const MyText(
              WordStrings.exitAppTitle,
              fontSize: 18,
              fontColor: yasRed,
              fontWeight: FontWeight.bold,
            ),
            content: const MyText(
              WordStrings.exitAppMsg,
              fontSize: 14,
              fontColor: stdBlack,
            ),
            actions: [
              Row(
                children: [
                  MyButton(
                    label: WordStrings.btnNo,
                    style: const TextStyle(
                      color: whiteTxt,
                      fontWeight: FontWeight.bold,
                    ),
                    height: Get.height * 0.03,
                    width: Get.width * 0.2,
                    borderRadius: 2,
                    onTap: () => Navigator.of(context).pop(false),
                  )..paddingOnly(left: 4, right: 4),
                  const Spacer(),
                  MyButton(
                    label: WordStrings.btnYes,
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
    StorageHelper.read(StorageKeys.userData)
        .then((value) => {points = value['points']});
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showWarning(context);
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
                child: Center(
                  child: MyImage(
                    image: AssetImages.splashLogo,
                    height: 45.h,
                  ),
                ).paddingOnly(top: Get.height * 0.05),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyText(
                          WordStrings.userLblHome,
                          fontWeight: FontWeight.normal,
                          fontFamily: FontFamilyConstant.sinkinSansMedium,
                          fontSize: 12,
                          fontColor: stdgrey,
                        ),
                        MyText(
                          'Himadri',
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamilyConstant.sinkinSansMedium,
                          fontSize: 14,
                          fontColor: yasRed,
                        ),
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
                        MyText(
                          "$points ${WordStrings.pointLblHome}",
                          // "${controller.userData.value.points} ${WordStrings.pointLblHome}",
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamilyConstant.sinkinSansMedium,
                          fontSize: 14,
                          fontColor: yasRed,
                        ),
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
                  Get.toNamed(AppRoutes.profileScreen);
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
                  Get.toNamed(AppRoutes.caseListScreen);
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
}
