import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/snack.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_button.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/common/widgets/my_textfield.dart';
import 'package:qulip/controller/login_controller.dart';

class MyBottomSheet {
  final loginController = Get.find<LoginController>();
  // final BaseController con = Get.put(BaseController());

  Future<bool> loginBottomSheet() async {
    bool result = false;
    await Get.bottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.white,
      SizedBox(
        height: Get.height * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.close,
                  color: stdBlack,
                  size: 25,
                ),
              ),
            ).paddingOnly(right: 20.w),
            const MyText(
              'Hello,',
              fontWeight: FontWeight.bold,
              fontFamily: FontFamilyConstant.sinkinSansMedium,
              fontSize: 18,
              fontColor: yasRed,
            ).paddingOnly(top: 10.h).paddingSymmetric(horizontal: 20.w),
            const MyText(
              'To get started, please verify your mobile number.',
              fontFamily: FontFamilyConstant.sinkinSansMedium,
            ).paddingOnly(top: 10.h).paddingSymmetric(horizontal: 20.w),
            const Spacer(),
            MyTextField(
              fullBorder: true,
              hasFloatingLabel: false,
              controller: loginController.txtPhone,
              maxLength: 10,
              keyboard: TextInputType.number,
              labelText: WordStrings.mobileLbl,
              hintText: WordStrings.mobileLbl,
            ).paddingOnly(top: 10.h).paddingSymmetric(horizontal: 20.w),
            const Spacer(
              flex: 2,
            ),
            MyButton(
              label: 'Verify ',
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
                if (loginController.txtPhone.text.length == 10) {
                  // await loginController.signIn();

                  Get.back();

                  // if (loginController.userData.value.otp != null) {

                  // }
                } else {
                  if (loginController.txtPhone.text.isEmpty) {
                    MySnackBar.errorSnackbar('Please Enter Mobile Number!');
                  } else {
                    MySnackBar.errorSnackbar(
                      'Please Enter Vaild Mobile Number!',
                    );
                  }
                }
              },
            )
                .paddingOnly(top: Get.height * 0.04, bottom: 30.h)
                .paddingSymmetric(horizontal: 20),
            SizedBox(
              height: Get.height * 0.03,
            ),
          ],
        ),
      ),
    );
    return result;
  }
}
