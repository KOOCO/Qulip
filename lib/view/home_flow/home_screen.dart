import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_button_with_icon.dart';
import 'package:qulip/common/widgets/my_image.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/controller/login_controller.dart';
import 'package:qulip/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyText(
                        WordStrings.pointLblHome,
                        fontWeight: FontWeight.normal,
                        fontFamily: FontFamilyConstant.sinkinSansMedium,
                        fontSize: 12,
                        fontColor: stdgrey,
                      ),
                      MyText(
                        '100 points',
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
                Get.toNamed(AppRoutes.caseListScreen);
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
              onTap: () async {},
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
    );
  }
}
