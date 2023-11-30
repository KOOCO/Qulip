import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_button.dart';
import 'package:qulip/common/widgets/my_image.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/common/widgets/my_textfield.dart';
import 'package:qulip/controller/login_controller.dart';
import 'package:qulip/routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: stdwhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: MyImage(
                image: AssetImages.splashLogo,
                height: 65.h,
              ),
            ).paddingOnly(top: Get.height * 0.10),
            SizedBox(
              height: Get.height * 0.06,
            ),
            MyTextField(
              fullBorder: true,
              hasFloatingLabel: false,
              controller: controller.txtPhone,
              maxLength: 10,
              keyboard: TextInputType.text,
              labelText: WordStrings.mobileLbl,
              hintText: WordStrings.mobileLbl,
            ).paddingOnly(top: 10.h).paddingSymmetric(horizontal: 20.w),
            MyTextField(
              fullBorder: true,
              hasFloatingLabel: false,
              controller: controller.txtPassword,
              maxLength: 16,
              keyboard: TextInputType.text,
              labelText: WordStrings.passwordLbl,
              hintText: WordStrings.passwordLbl,
            ).paddingOnly(top: 20.h).paddingSymmetric(horizontal: 20.w),
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    activeColor: yasRed,
                    value: controller.isRemember.value,
                    onChanged: (value) {
                      controller.isRemember.value = value!;
                    },
                  ),
                ),
                const MyText(
                  WordStrings.remmeberLbl,
                  fontStyle: TextStyle(
                    fontFamily: FontFamilyConstant.sinkinSans,
                    color: stdDarkGray,
                  ),
                )
              ],
            ).paddingSymmetric(horizontal: 10.w),
            MyButton(
              label: WordStrings.loginLbl,
              style: const TextStyle(
                color: whiteTxt,
                fontWeight: FontWeight.bold,
              ),
              decoration: const BoxDecoration(
                color: yasRed,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.black54,
                  )
                ],
              ),
              height: Get.height * 0.05,
              borderRadius: 2,
              onTap: () async {
                Get.toNamed(AppRoutes.homeScreen);
                // controller.loginMobile();
              },
            )
                .paddingOnly(top: Get.height * 0.04)
                .paddingSymmetric(horizontal: 20),
            MyButton(
              label: WordStrings.signupLbl,
              style: const TextStyle(
                color: whiteTxt,
                fontWeight: FontWeight.bold,
              ),
              decoration: const BoxDecoration(
                color: yasRed,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.black54,
                  )
                ],
              ),
              height: Get.height * 0.05,
              borderRadius: 2,
              onTap: () async {
                Get.toNamed(AppRoutes.signupScreen);
              },
            ).paddingOnly(top: 20.h).paddingSymmetric(horizontal: 20),
          ],
        ),
      ),
    );
  }
}
