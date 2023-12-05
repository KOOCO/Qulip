import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qulip/common/assests.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/common/widgets/my_button.dart';
import 'package:qulip/common/widgets/my_text.dart';
import 'package:qulip/common/widgets/my_textfield.dart';
import 'package:qulip/controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: stdwhite,
        foregroundColor: yasRed,
        centerTitle: true,
        title: const MyText(
          WordStrings.profileLblHome,
          fontFamily: FontFamilyConstant.sinkinSans,
          fontSize: 18,
          fontColor: yasRed,
        ),
      ),
      backgroundColor: transparentGrey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.06,
            ),
            MyTextField(
              enabled: false,
              readOnly: true,
              fullBorder: true,
              hasFloatingLabel: false,
              controller: controller.txtAccount,
              maxLength: 10,
              keyboard: TextInputType.text,
              labelText: WordStrings.profileAccountNoLbl,
              hintText: WordStrings.profileAccountNoLbl,
            ).paddingSymmetric(vertical: 10.h),
            MyTextField(
              fullBorder: true,
              hasFloatingLabel: false,
              controller: controller.txtPassword,
              maxLength: 10,
              keyboard: TextInputType.text,
              labelText: WordStrings.profilePasswordLbl,
              hintText: WordStrings.profilePasswordLbl,
            ).paddingSymmetric(vertical: 10.h),
            MyTextField(
              fullBorder: true,
              hasFloatingLabel: false,
              controller: controller.txtName,
              maxLength: 10,
              keyboard: TextInputType.text,
              labelText: WordStrings.profileNameLbl,
              hintText: WordStrings.profileNameLbl,
            ).paddingSymmetric(vertical: 10.h),
            MyTextField(
              fullBorder: true,
              hasFloatingLabel: false,
              controller: controller.txtEmail,
              maxLength: 10,
              keyboard: TextInputType.text,
              labelText: WordStrings.profileEmailLbl,
              hintText: WordStrings.profileEmailLbl,
            ).paddingSymmetric(vertical: 10.h),
            MyTextField(
              fullBorder: true,
              hasFloatingLabel: false,
              controller: controller.txtAddress,
              maxLength: 10,
              keyboard: TextInputType.text,
              labelText: WordStrings.profileAddressLbl,
              hintText: WordStrings.profileAddressLbl,
            ).paddingSymmetric(vertical: 10.h),
            MyTextField(
              fullBorder: true,
              hasFloatingLabel: false,
              controller: controller.txtAffiUId,
              maxLength: 10,
              keyboard: TextInputType.text,
              labelText: WordStrings.profileUnitId,
              hintText: WordStrings.profileUnitId,
            ).paddingSymmetric(vertical: 10.h),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  WordStrings.pointLblHome,
                  fontWeight: FontWeight.normal,
                  fontFamily: FontFamilyConstant.sinkinSansMedium,
                  fontSize: 12,
                  fontColor: yasRed,
                ),
                MyText(
                  '100 points',
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamilyConstant.sinkinSansMedium,
                  fontSize: 14,
                  fontColor: yasRed,
                ),
              ],
            ).paddingSymmetric(vertical: 4.h),
            SizedBox(
              height: Get.height * 0.04,
            ),
            MyButton(
              label: WordStrings.btnSaveLbl,
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
              onTap: () async {},
            ).paddingSymmetric(vertical: 10),
            // MyButton(
            //   label: WordStrings.btnCancelLbl,
            //   style: const TextStyle(
            //     color: whiteTxt,
            //     fontWeight: FontWeight.bold,
            //   ),
            //   decoration: const BoxDecoration(
            //     color: yasRed,
            //     borderRadius: BorderRadius.all(Radius.circular(5)),
            //     boxShadow: [
            //       BoxShadow(
            //         blurRadius: 6,
            //         color: Colors.black54,
            //       )
            //     ],
            //   ),
            //   height: Get.height * 0.05,
            //   borderRadius: 2,
            //   onTap: () async {},
            // )
          ],
        ),
      ).paddingSymmetric(horizontal: 24.w, vertical: 4.h),
    );
  }
}
